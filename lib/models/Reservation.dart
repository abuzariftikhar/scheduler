import 'package:flutter/material.dart';
import 'package:scheduler/models/ServiceModel.dart';

class Reservation {
  String id;
  final String userId;
  final List<ServiceItem> listOfServices;
  final String date;
  final List<int> slots;

  Reservation({
    this.id = '',
    @required this.userId,
    @required this.listOfServices,
    @required this.date,
    @required this.slots,
  });

  factory Reservation.fromMap(Map<String, dynamic> reservation) {
    return Reservation(
      id: reservation["id"],
      userId: reservation["userId"],
      listOfServices: reservation["listOfServices"],
      date: reservation["date"],
      slots: reservation["slots"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "listOfServices": listOfServices,
      "date": date,
      "slots": slots,
    };
  }
}
