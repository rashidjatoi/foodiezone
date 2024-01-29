import 'package:flutter/material.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/screens/food_driver_screen/food_driver_create_account_screen.dart';
import 'package:foodiezone/screens/food_driver_screen/food_driver_orders_details_screen.dart';
import 'package:foodiezone/services/auth_services.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

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
              "assets/images/foodDelivery.png",
              height: 250,
            ),
          ),
          const SizedBox(height: 60),
          CustomButton(
            btnText: 'View Delivery Orders',
            ontap: () {
              Get.to(() => const FoodDriverOrdersDetailsScreen());
            },
          )
        ],
      ),
    );
  }
}
