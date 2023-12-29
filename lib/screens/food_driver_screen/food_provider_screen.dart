import 'package:flutter/material.dart';
import 'package:foodiezone/screens/food_driver_screen/food_driver_create_account_screen.dart';
import 'package:foodiezone/screens/food_driver_screen/food_driver_orders_details_screen.dart';
import 'package:foodiezone/screens/food_provider/widgets/admin_view_btn.dart';
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
        title: const Text('Food Delevery'),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              FoodProviderViewButton(
                ontap: () {
                  Get.to(() => const FoodDriverAccountDetailsView());
                },
                icon: IconlyBold.profile,
                iconText: "Create Profile",
              ),
              FoodProviderViewButton(
                ontap: () {
                  Get.to(() => const FoodDriverOrdersDetailsScreen());
                },
                icon: IconlyBold.bookmark,
                iconText: "View Food Orders",
              ),
            ],
          ),
          // Row(
          //   children: [
          //     FoodProviderViewButton(
          //       ontap: () {},
          //       icon: IconlyBold.profile,
          //       iconText: "Pending Orders",
          //     ),
          //     FoodProviderViewButton(
          //       ontap: () {},
          //       icon: IconlyBold.profile,
          //       iconText: "Confirm Orders",
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
