import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/images.dart';
import 'package:foodiezone/constants/widgets.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/screens/role/check_role.dart';
import 'package:foodiezone/services/services_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  void splashScreenCounter() {
    if (user != null) {
      timer = Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const RoleCheckScreen()));
      });
    } else {
      timer = Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginView()));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    splashScreenCounter();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              appLogo,
              height: 150,
            ),
            const SizedBox(height: 20),
            // App Slogan
            sloganWidget,
          ],
        ),
      ),
    );
  }
}
