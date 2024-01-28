import 'package:flutter/material.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/screens/food_provider/confirm_order/confirm_orders_screen.dart';
import 'package:foodiezone/screens/food_provider/food_items/food_items.dart';
import 'package:foodiezone/screens/food_provider/food_provider_details/food_provider_details.dart';
import 'package:foodiezone/services/auth_services.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../constants/colors.dart';

class FoodProviderAccount extends StatefulWidget {
  const FoodProviderAccount({super.key});

  @override
  State<FoodProviderAccount> createState() => _FoodProviderAccountState();
}

class _FoodProviderAccountState extends State<FoodProviderAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Food Provider Panel"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const FoodProviderDetailsView());
            },
            icon: const Icon(IconlyLight.edit),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {
              AuthServices.signOutUser().then(
                (value) {
                  Get.offAll(() => const LoginView());
                },
              );
            },
            icon: const Icon(IconlyLight.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/foodDriver.png",
            height: 250,
          ),
          const SizedBox(height: 40),
          CustomButton(
            btnText: 'View Confirm Orders',
            ontap: () {
              Get.to(() => const ConfirmOrderScreen());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appcolor,
        onPressed: () {
          Get.to(() => const FoodItemsView());
        },
        child: const Icon(
          IconlyLight.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
