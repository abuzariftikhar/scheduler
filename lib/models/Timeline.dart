import 'package:flutter/material.dart';

class Timeline {
  String id;
  final String date;
  final List<int> slotsReserved;

  Timeline({
    this.id = "",
    @required this.date,
    @required this.slotsReserved,
  });

  factory Timeline.fromMap(Map<String, dynamic> reservedHours) {
    return Timeline(
      id: reservedHours["id"],
      date: reservedHours["date"],
      slotsReserved: reservedHours["slotsReserved"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "slotsReserved": slotsReserved.cast<int>(),
    };
  }
}
