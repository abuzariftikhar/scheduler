import 'package:flutter/material.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/repository/ServicesRepository.dart';

class ServicesManagerBloc extends ChangeNotifier {
  int index = 0;
  ServiceReopsitory _reopsitory = ServiceRepositoryImpl();
  bool isLoading = true;
  List<ServiceItem> servicesList = [];

  Future loadServicesbyType(String type) async {
    isLoading = true;
    servicesList = await _reopsitory.getServicesbyType(type);
    isLoading = false;
    notifyListeners();
  }

  Future loadAllServices(String currentUser) async {
    isLoading = true;
    servicesList = await _reopsitory.getAllservices(currentUser);
    isLoading = false;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
