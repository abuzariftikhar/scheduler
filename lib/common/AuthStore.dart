import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class CurrentUser {
  final bool initialState;
  final User firebaseUser;

  const CurrentUser._(this.initialState, this.firebaseUser);
  factory CurrentUser.createUser(User userData) =>
      CurrentUser._(false, userData);

  static const initial = CurrentUser._(true, null);
}
