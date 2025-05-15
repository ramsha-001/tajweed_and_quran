import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static bool _isAuthenticated = false;

  static bool get isAuthenticated => _isAuthenticated;

  static Future<void> login() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    }
  }

  static void logout() {
    _isAuthenticated = false;
  }
}