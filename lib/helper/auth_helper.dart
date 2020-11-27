import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  static Future<void> login(String email, String password) async {
    final _firebaseAuth = FirebaseAuth.instance;
    try {
      return _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      throw error;
    }
  }

  static Future<void> signUpWithEmail(
      String email,
      String password,
      String fullName,
      Timestamp birthDay,
      String gender,
      String address) async {
    print("----------- SignUp Email--------------");
    print(email);
    print(password);
    print(fullName);
    print(birthDay);
    print(gender);
    print(address);
    final _auth = FirebaseAuth.instance;
    try {
      AuthResult authResult;
      authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await authResult.user.sendEmailVerification();
      return Firestore.instance
          .collection('user_credentials')
          .document(authResult.user.uid)
          .setData({
        'email': email,
        'fullName': fullName,
        'birthDay': birthDay,
        'gender': gender,
        'address': address
      });
    } catch (error) {
      print('SignIn Function error');
      print(error);
      throw error;
    }
  }

  static Future<void> editCredential(String fullName, String address) async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return Firestore.instance
        .collection('user_credentials')
        .document(currentUser.uid)
        .updateData({
      'fullName': fullName,
      'address': address,
    });
  }

  static Future<void> resetPassword(String email) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
