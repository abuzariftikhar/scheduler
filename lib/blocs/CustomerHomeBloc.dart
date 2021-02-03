import 'package:flutter/material.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/repository/ServicesRepository.dart';

class CustomerHomeBloc extends ChangeNotifier {
  int index = 0;
  int previousIndex =1;
  int filterIndex = 0;
  String filterTitle = "Hair Cutting";
  ServiceReopsitory _reopsitory = ServiceRepositoryImpl();
  bool isLoading = true;
  List<ServiceItem> servicesList = [];
  List<ServiceItem> bannerList = [];
  List<ServiceItem> trendingList = [];

  Future loadServicesbyType(String type) async {
    isLoading = true;
    servicesList.clear();
    servicesList = await _reopsitory.getServicesbyType(type);
    isLoading = false;
    notifyListeners();
  }

  Future loadHomeServices() async {
    isLoading = true;
    trendingList.clear();
    bannerList.clear();
    trendingList = await _reopsitory.getServicesbyCategory("Popular");
    bannerList = await _reopsitory.getServicesbyCategory("Banner");
    trendingList.shuffle();
    bannerList.shuffle();
    isLoading = false;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
