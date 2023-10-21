import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/images.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  void splashScreenCounter() {
    timer = Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );

      // Get.off(() => HomeScreen);
    });
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
        child: Image.asset(appLogo),
      ),
    );
  }
}
