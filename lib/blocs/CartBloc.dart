import 'package:flutter/material.dart';
import 'package:scheduler/models/ServiceModel.dart';

class CartBloc extends ChangeNotifier {
  List<ServiceItem> cartItems = [];
  int totalSlotsRequired = 0;
  double totalCost = 0;

  bool isLoading = false;

  void update() {
    notifyListeners();
  }

  bool addtocart(ServiceItem serviceItem) {
    print(serviceItem.id);
    bool itemExist = true;
    itemExist = cartItems.any((element) {
      return element.id == serviceItem.id;
    });
    print(itemExist);
    if (!itemExist) {
      cartItems.add(serviceItem);
    }
    _loadTotalPrice();
    _loadTotaltime();
    notifyListeners();
    return itemExist;
  }

  void removeFromCart(ServiceItem serviceItem) {
    cartItems.remove(serviceItem);
    _loadTotalPrice();
    _loadTotaltime();
    notifyListeners();
  }

  Future _loadTotaltime() async {
    double _num = 0;
    cartItems.forEach((element) {
      _num = _num + element.timeRequired / 15;
    });
    totalSlotsRequired = _num.toInt();
  }

  Future _loadTotalPrice() async {
    double _num = 0;
    cartItems.forEach((element) {
      _num = _num + double.parse(element.cost);
    });
    totalCost = _num;
  }

  String durationToString(int totalminutes) {
    final int hour = totalminutes ~/ 60;
    final int minutes = totalminutes % 60;
    String result = "";
    if (hour == 0)
      result = '${minutes.toString().padLeft(2, "0")} minutes';
    else if (hour == 1 && minutes == 0)
      result = '${hour.toString().padLeft(2, "0")} hour';
    else if (hour > 1 && minutes == 0)
      result = '${hour.toString().padLeft(2, "0")} hours';
    else if (hour > 1 && minutes > 1)
      result =
          '${hour.toString().padLeft(2, "0")} hours ${minutes.toString().padLeft(2, "0")} minutes';
    else if (hour == 1 && minutes > 1)
      result =
          '${hour.toString().padLeft(2, "0")} hour ${minutes.toString().padLeft(2, "0")} minutes';

    return result;
  }
}
