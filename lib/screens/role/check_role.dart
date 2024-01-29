import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/admin/admin_view.dart';
import 'package:foodiezone/screens/bottom_navigation/bottom_nav_bar.dart';

import '../food_driver_screen/food_provider_screen.dart';
import '../food_provider/food_provider_account/food_provider_bottom.dart';

class RoleCheckScreen extends StatelessWidget {
  const RoleCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref('users');

    return StreamBuilder(
      stream: ref.onValue,
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
        final user = firebaseAuth.currentUser;
        final uid = user?.uid;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
          final role = map[uid]["role"];

          if (role == 'admin') {
            return const AdminView();
          } else if (role == 'user') {
            return const BottomNavigationBarView();
          } else if (role == 'foodProvider') {
            return const FoodBottomNavigationBarView();
          } else if (role == 'foodRider') {
            return const FoodDriverView();
          } else if (role == 'user') {
            return const BottomNavigationBarView();
          }
        }

        return const BottomNavigationBarView();
      },
    );
  }
}
