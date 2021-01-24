import 'package:flutter/material.dart';
import 'package:scheduler/models/ServiceModel.dart';

class Reservation {
  String id;
  final String userId;
  final List<ServiceItem> listOfServices;
  final DateTime startDateTime;

  Reservation({
    this.id = '',
    @required this.userId,
    @required this.listOfServices,
    @required this.startDateTime,
  });

  factory Reservation.fromMap(Map<String, dynamic> reservation) {
    return Reservation(
      id: reservation["id"],
      userId: reservation["userId"],
      listOfServices: reservation["listOfServices"],
      startDateTime: reservation["startDateTime"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "listOfServices": listOfServices,
      "startDateTime": startDateTime,
    };
  }
}
