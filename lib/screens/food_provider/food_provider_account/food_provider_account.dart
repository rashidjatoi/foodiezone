import 'package:flutter/material.dart';
import 'package:foodiezone/screens/food_provider/food_items/food_items.dart';
import 'package:foodiezone/screens/food_provider/food_provider_details/food_provider_details.dart';
import 'package:foodiezone/screens/food_provider/widgets/admin_view_btn.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              FoodProviderViewButton(
                ontap: () {
                  Get.to(() => const FoodProviderDetailsView());
                },
                icon: IconlyBold.profile,
                iconText: "Create Profile",
              ),
              FoodProviderViewButton(
                ontap: () {
                  Get.to(() => const FoodItemsView());
                },
                icon: IconlyBold.bookmark,
                iconText: "Add Food Items",
              ),
            ],
          ),
          Row(
            children: [
              FoodProviderViewButton(
                ontap: () {},
                icon: IconlyBold.profile,
                iconText: "Pending Orders",
              ),
              FoodProviderViewButton(
                ontap: () {},
                icon: IconlyBold.profile,
                iconText: "Confirm Orders",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
