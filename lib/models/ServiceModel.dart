import 'package:flutter/material.dart';

class ServiceModel {
  String id;
  final String name;
  final int timeRequired;
  final String type;
  final String badge;
  final String imageURL;
  final String cost;
  final String detailText;

  ServiceModel({
    this.id = "",
    @required this.name,
    @required this.type,
    @required this.badge,
    @required this.cost,
    @required this.timeRequired,
    @required this.imageURL,
    @required this.detailText,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> item) {
    return ServiceModel(
      id: item["id"],
      name: item["name"],
      type: item["type"],
      badge: item["badge"],
      cost: item["cost"],
      timeRequired: item["timeRequired"],
      imageURL: item["imageURL"],
      detailText: item["detailText"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "badge": badge,
      "cost": cost,
      "timeRequired": timeRequired,
      "imageURL": imageURL,
      "detailText": detailText,
    };
  }
}
