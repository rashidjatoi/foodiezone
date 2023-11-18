import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/admin/admin_view.dart';
import 'package:foodiezone/screens/bottom_navigation/bottom_nav_bar.dart';
import 'package:foodiezone/screens/home/home_screen.dart';

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
          // print(role);

          if (role == 'admin') {
            // Navigate to admin panel
            return const AdminView();
          } else if (role == 'user') {
            // Navigate to admin panel
            return const HomeView();
          } else if (role == 'user') {
            // Navigate to home screen
            return const HomeView();
          }
        }

        // Default case, navigate to login screen
        return const BottomNavigationBarView();
      },
    );
  }
}
