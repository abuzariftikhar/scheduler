import 'package:flutter/material.dart';
import 'package:scheduler/models/ServiceModel.dart';

class CartBloc extends ChangeNotifier {
  List<ServiceItem> cartItems = [];
  String addtocart(ServiceItem serviceItem) {
    if (!cartItems.contains(serviceItem)) {
      cartItems.add(serviceItem);
      notifyListeners();
      return "Item added to cart";
    } else {
      return "Item already added to cart";
    }
  }

  void removeFromCart(ServiceItem serviceItem) {
    cartItems.remove(serviceItem);
    notifyListeners();
  }

  Duration getTotalTime(List<Duration> durationList) {
    Duration _totalDuration;
    durationList.forEach((element) {
      _totalDuration = _totalDuration + element;
    });
    return _totalDuration;
  }
}
