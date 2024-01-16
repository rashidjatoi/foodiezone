import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'services_constants.dart';

class DatabaseServices {
  // Save users data to the database
  static Future saveUserCredentials({
    required String email,
    required String username,
    required String phone,
    required String date,
    required String gender,
    required String cnic,
    required String role,
    required String address,
  }) async {
    final user = firebaseAuth.currentUser;
    try {
      await firebaseDatabase.child(user!.uid).set({
        "username": username,
        "userId": user.uid,
        "email": email,
        "address": address,
        "phone": phone,
        "date": date,
        "cninc": cnic,
        "gender": gender,
        "role": role,
        "Timestamp": DateTime.now().toString(),
      }).then((value) => Utils.showToast(
            message: 'Profile Updated',
            bgColor: Colors.red,
            textColor: Colors.white,
          ));
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  static Future saveFoodProviderDetails({
    required String email,
    required String username,
    required String phone,
    required String address,
    required String newUrl,
  }) async {
    final user = firebaseAuth.currentUser;
    try {
      await foodProviderDatabase.child(user!.uid).set({
        "username": username,
        "userId": user.uid,
        "email": email,
        "address": address,
        'imageUrl': newUrl,
        "phone": phone,
        "role": "foodprovider",
        "Timestamp": DateTime.now().toString(),
      }).then((value) => Utils.showToast(
            message: 'Company Created',
            bgColor: Colors.red,
            textColor: Colors.white,
          ));
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  static Future saveFoodDriverDetails({
    required String email,
    required String username,
    required String phone,
    required String address,
  }) async {
    final user = firebaseAuth.currentUser;
    try {
      await foodDriverDatabase.child(user!.uid).set({
        "username": username,
        "userId": user.uid,
        "email": email,
        "address": address,
        "phone": phone,
        "role": "fooddriver",
        "Timestamp": DateTime.now().toString(),
      }).then((value) => Utils.showToast(
            message: 'Company Created',
            bgColor: Colors.red,
            textColor: Colors.white,
          ));
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  static Future saveFoodOrders({
    required Map<String, dynamic> order,
  }) async {
    final user = firebaseAuth.currentUser;
    try {
      await firebaseDatabase
          .child(user!.uid)
          .child('order')
          .push()
          .set(
            order,
          )
          .then((value) => Utils.showToast(
                message: 'Order Placed',
                bgColor: Colors.red,
                textColor: Colors.white,
              ));
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  static Future saveFoodOrdersSection({
    required String email,
    required String username,
    required String phone,
    required String address,
  }) async {
    final user = firebaseAuth.currentUser;
    try {
      await foodProviderDatabase.child(user!.uid).set({
        "username": username,
        "userId": user.uid,
        "email": email,
        "address": address,
        "phone": phone,
        "role": "foodprovider",
        "Timestamp": DateTime.now().toString(),
      }).then((value) => Utils.showToast(
            message: 'Company Created',
            bgColor: Colors.red,
            textColor: Colors.white,
          ));
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  // Post User Messages
  static Future postMessages({message}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;
      final user = firebaseAuth.currentUser!.email;
      final uid = firebaseAuth.currentUser!.uid;

      await helpdeskDatabase.child(uid.toString()).child(id.toString()).set({
        "id": id,
        "UserEmail": user,
        "Message": message,
        "Timestamp": DateTime.now().toString(),
        "IsAdminMessage": false, // Indicates that it's a user message
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

// Post Admin Messages
  static Future postAdminMessages(
      {message, required String recipientEmail, required String uid}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;

      await helpdeskDatabase.child(uid.toString()).child(id.toString()).set({
        "id": id,
        "UserEmail": recipientEmail,
        "uid": uid,
        "Message": message,
        "Timestamp": DateTime.now().toString(),
        "IsAdminMessage": true,
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
