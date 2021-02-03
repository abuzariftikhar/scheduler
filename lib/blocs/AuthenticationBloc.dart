import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationBloc extends ChangeNotifier {
  bool adminMode = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String registrationError = "";
  String signInError = "";
  bool isBusy = false;

  Future<bool> registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      isBusy = true;
      notifyListeners();
      await auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => value.user.updateProfile(
                displayName: displayName,
              ));
      isBusy = false;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        registrationError = "Please use a strong password.";
      } else if (e.code == 'email-already-in-use') {
        registrationError = "Email is already in use.";
      }
      isBusy = false;
      notifyListeners();
      return false;
    } catch (e) {
      registrationError = "Something went wrong! Please try again.";
      isBusy = false;
      notifyListeners();
      return false;
    }
  }

  Future continueAsGuestUser() async {
    await auth.signInAnonymously();
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    isBusy = true;
    notifyListeners();
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      isBusy = false;
      return true;
    } catch (e) {
      if (e.code == 'user-not-found') {
        signInError = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        signInError = 'Incorrect password';
      }
      isBusy = false;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    await auth.signOut();
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
