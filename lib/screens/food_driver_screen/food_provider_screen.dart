import 'package:flutter/material.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/screens/food_driver_screen/food_driver_create_account_screen.dart';
import 'package:foodiezone/screens/food_driver_screen/food_driver_orders_details_screen.dart';
import 'package:foodiezone/services/auth_services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../constants/colors.dart';

class FoodDriverView extends StatefulWidget {
  const FoodDriverView({super.key});

  @override
  State<FoodDriverView> createState() => _FoodDriverViewState();
}

class _FoodDriverViewState extends State<FoodDriverView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Delivery'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const FoodDriverAccountDetailsView());
            },
            icon: const Icon(
              IconlyLight.edit,
            ),
          ),
          IconButton(
            onPressed: () {
              AuthServices.signOutUser().then(
                (value) => Get.offAll(
                  () => const LoginView(),
                ),
              );
            },
            icon: const Icon(
              IconlyLight.logout,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/foodDriver.png",
              height: 250,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appcolor,
        onPressed: () {
          Get.to(() => const FoodDriverOrdersDetailsScreen());
        },
        child: const Icon(
          Icons.remove_red_eye_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
