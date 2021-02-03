import 'package:flutter/material.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/models/Timeline.dart';
import 'package:scheduler/repository/ReservationRepsitory.dart';

class CartBloc extends ChangeNotifier {
  List<ServiceItem> cartItems = [];
  int totalSlotsRequired = 0;
  double totalCost = 0;

  ReservationReopsitory _reservationReopsitory = ReservationRepositoryImpl();
  bool isLoading = false;
  int requiredSlot = 4;
  int index = 0;
  int previousIndex = 0;
  List<TimeOfDay> totalSlots = [];
  List<int> reservedSlots = [];
  List<int> currentSelection = [];

  void reset() {
    index = 0;
    previousIndex = 0;
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

  void loadHours() {
    totalSlots.clear();
    var hour = TimeOfDay(hour: 00, minute: 0);
    while (hour.before(TimeOfDay(hour: 23, minute: 61))) {
      totalSlots.add(hour);
      hour = hour.add(minutes: 15);
    }
  }

  Future loadReservedHours(String date) async {
    reservedSlots.clear();
    isLoading = true;
    var _list = await _reservationReopsitory.getReservedHours(date);
    _list.map((e) => e.slotsReserved.forEach((element) {
          reservedSlots.add(element);
        }));
    isLoading = false;
    notifyListeners();
  }

  Future postReservationSlots(Timeline timeline) async {
    isLoading = true;
    bool result = await _reservationReopsitory.createReservedHours(timeline);
    isLoading = false;
    notifyListeners();
    return result;
  }

  void update() {
    notifyListeners();
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compare(TimeOfDay other) {
    return this.inMinutes() - other.inMinutes();
  }

  int inMinutes() {
    return this.hour * 60 + this.minute;
  }

  bool before(TimeOfDay other) {
    return this.compare(other) < 0;
  }

  bool after(TimeOfDay other) {
    return this.compare(other) > 0;
  }

  TimeOfDay add({int minutes}) {
    final total = this.inMinutes() + minutes;
    return TimeOfDay(hour: total ~/ 60, minute: total % 60);
  }
}
