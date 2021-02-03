import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ApplicationBloc extends ChangeNotifier {
  User firebaseUser;
  Future setLogin(bool isAuthenticated) async {
    if (isAuthenticated) {
      firebaseUser = FirebaseAuth.instance.currentUser;
    } else {
      firebaseUser = null;
      FirebaseAuth.instance.signOut();
    }
  }
}
