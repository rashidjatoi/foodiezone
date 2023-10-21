import 'package:flutter/material.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              firebaseAuth
                  .signOut()
                  .then((value) => Get.offAll(() => const LoginView()));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
