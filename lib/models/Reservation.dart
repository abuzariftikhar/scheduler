import 'package:flutter/material.dart';
import 'package:scheduler/models/ServiceModel.dart';

class Reservation {
  String id;
  final String userId;
  final String status;
  final List<ServiceModel> listOfServices;
  final DateTime startTime;
  final DateTime endTime;

  Reservation({
    this.id = '',
    @required this.userId,
    @required this.status,
    @required this.listOfServices,
    @required this.startTime,
    @required this.endTime,
  });

  factory Reservation.fromMap(Map<String, dynamic> reservation) {
    return Reservation(
      id: reservation["id"],
      userId: reservation["userId"],
      status: reservation["status"],
      listOfServices: reservation["listOfServices"],
      startTime: reservation["startTime"],
      endTime: reservation["endTime"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "status": status,
      "listOfServices": listOfServices,
      "startTime": startTime,
      "endTime": endTime,
    };
  }
}
