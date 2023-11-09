import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/onboard/landing_screen.dart';
import 'package:foodiezone/screens/role/check_role.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:foodiezone/utils/helper.dart';

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
            MaterialPageRoute(builder: (context) => const LandingScreen()));
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
      body: SizedBox(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                Helper.getAssetName("splashIcon.png", "virtual"),
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/logo.png',
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
