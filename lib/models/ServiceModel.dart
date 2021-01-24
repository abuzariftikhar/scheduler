import 'package:flutter/material.dart';

class ServiceItem {
  String id;
  final String name;
  final int color;
  final int timeRequired;
  final String type;
  final String category;
  final String imageURL;
  final String cost;
  final String detailText;

  ServiceItem({
    this.id = "",
    @required this.color,
    @required this.name,
    @required this.type,
    @required this.category,
    @required this.cost,
    @required this.timeRequired,
    @required this.imageURL,
    @required this.detailText,
  });

  factory ServiceItem.fromMap(Map<String, dynamic> item) {
    return ServiceItem(
      id: item["id"],
      color: item["color"],
      name: item["name"],
      type: item["type"],
      category: item["category"],
      cost: item["cost"],
      timeRequired: item["timeRequired"],
      imageURL: item["imageURL"],
      detailText: item["detailText"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "color": color,
      "name": name,
      "type": type,
      "category": category,
      "cost": cost,
      "timeRequired": timeRequired,
      "imageURL": imageURL,
      "detailText": detailText,
    };
  }
}
