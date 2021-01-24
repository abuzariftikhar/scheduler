import 'package:flutter/material.dart';

class Shop {
  final String shopName;
  final String openingTime;
  final String closingTime;
  final List<DayPeriod> daysOpened;

  Shop({
    @required this.shopName,
    @required this.openingTime,
    @required this.closingTime,
    @required this.daysOpened,
  });
}
