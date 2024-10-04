import 'dart:async';
import 'custom_snack_bar.dart';
import 'package:flutter/material.dart';
import '../screens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Logout {
  final FirebaseAuth _firebaseAuth;

  Logout({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  logout(BuildContext context) async {
    _applyLogoutConfigs(context).then((value) async {});
  }

  Future _applyLogoutConfigs(BuildContext context) async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]).then((value) {
        FirebaseAuth.instance.currentUser?.reload();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()), (route) => route.isFirst,
        );
      });
    } catch (e) {
      debugPrint('LogOutFailure: ${e.toString()}');
      Future.delayed(const Duration(milliseconds: 100), () {
        CustomSnackBar().showSnackBar(
          context,
          msg: e.toString(),
          snackBarTypes: SnackBarTypes.error,
        );
      });
    }
  }
}
