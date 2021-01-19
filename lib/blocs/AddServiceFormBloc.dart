import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/repository/ServicesRepository.dart';

class AddServiceFormBloc extends ChangeNotifier {
  bool isPosting = false;
  ServiceReopsitory _servicesRepoHelper = ServiceRepositoryImpl();
  String title = "Default Title";
  String detailsText = "";
  String badge = "None";
  String serviceType = "Hair Cutting";
  String price = "12.99";
  int timeRequired = 15;
  String imageURL = "";
  File imageFile;
  final picker = ImagePicker();

  Future pickImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future uploadFile() async {
    isPosting = true;
    notifyListeners();
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('services_images/${imageFile.path.split('/').last}');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() async {
      imageURL = await storageReference.getDownloadURL();
    });
    print('File Uploaded @ $imageURL');
  }

  Future<bool> postService(ServiceModel serviceModel) async {
    bool result = await _servicesRepoHelper.createService(serviceModel);
    isPosting = false;
    notifyListeners();
    return result;
  }

  void update() {
    notifyListeners();
  }
}
