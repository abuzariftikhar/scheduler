import 'package:flutter/material.dart';

class UserModel {
  final String username;
  final String userID;
  final int role;

  UserModel({
    @required this.username,
    @required this.userID,
    @required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> item) {
    return UserModel(
      username: item["username"],
      userID: item["userID"],
      role: item["role"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "userID": userID,
      "role": role,
    };
  }
}
