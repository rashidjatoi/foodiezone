import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/bottom_navigation/bottom_nav_bar.dart';
import 'package:get/get.dart';
import '../utils/utils.dart';
import 'services_constants.dart';

class AuthServices {
  // Create user with email and password
  static Future createUser(email, password, username) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Utils.showToast(
              message: "Account Created",
              bgColor: Colors.grey,
              textColor: Colors.white,
            ),
          );

      // if (userCredential.user != null) {
      //   final user = firebaseAuth.currentUser;

      //   await firebaseDatabase.child(user!.uid).set({
      //     "username": username,
      //     "userId": user.uid,
      //     "email": email,
      //     "role": "user",
      //     "Timestamp": DateTime.now().toString(),
      //   });
      // }
    } on FirebaseAuthException catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // sign in  with email and password
  static Future signInUser(email, password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => {
              Utils.showToast(
                message: "Logged in",
                bgColor: Colors.grey,
                textColor: Colors.white,
              ),
              if (firebaseAuth.currentUser != null)
                {
                  Get.off(() => const BottomNavigationBarView()),
                }
            },
          );
    } on FirebaseAuthException catch (e) {
      Utils.showToast(
        message: e.code.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // Sign out
  static Future signOutUser() async {
    try {
      await firebaseAuth.signOut().then(
            (value) => Utils.showToast(
              message: "Sign Out",
              bgColor: Colors.grey,
              textColor: Colors.white,
            ),
          );
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
