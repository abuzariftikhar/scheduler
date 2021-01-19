import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService extends ChangeNotifier {
  bool isLoading = false;
  String errMessage = '';
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
    return "Sign out successful";
  }

  Future<bool> signIn(String email, String password) async {
    isLoading = true;
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      isLoading = false;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      errMessage = e.message;
      isLoading = false;
      return false;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return "Sign up sucessful";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
