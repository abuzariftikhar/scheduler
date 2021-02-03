import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/repository/ServicesRepository.dart';

class AddServiceFormBloc extends ChangeNotifier {
  int color = Colors.yellow.shade900.value;
  bool isBusy = false;
  ServiceReopsitory _servicesRepository = ServiceRepositoryImpl();
  String name = "Default Title";
  String detailsText = "Details";
  String category = "Expert";
  String type = "Hair Cutting";
  String cost = "12.99";
  int timeRequired = 15;
  List<String> imageURLs = [];
  List<File> imageFiles = [];
  final picker = ImagePicker();

  Future pickImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);
    imageFiles.add(File(pickedFile.path));
    notifyListeners();
  }

  Future getImageFilesFromAssets(List<Asset> assets) async {
    imageFiles.clear();
    isBusy = true;
    notifyListeners();
    for (var asset in assets) {
      final _byteData = await asset.getByteData();
      final _tempFile =
          File("${(await getTemporaryDirectory()).path}/${asset.name}");
      final _file = await _tempFile.writeAsBytes(
        _byteData.buffer
            .asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes),
      );
      imageFiles.add(_file);
    }
    notifyListeners();
    isBusy = false;
  }

  Future uploadFile() async {
    isBusy = true;
    notifyListeners();
    for (File file in imageFiles) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('services_images/${file.path.split('/').last}');
      UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() async {
        var _url = await storageReference.getDownloadURL();
        imageURLs.add(_url);
      });
    }
  }

  Future<bool> postService(ServiceItem serviceModel) async {
    bool result = await _servicesRepository.createService(serviceModel);
    isBusy = false;
    notifyListeners();
    return result;
  }

  void update() {
    notifyListeners();
  }
}
