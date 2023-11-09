import 'package:flutter/material.dart';
import 'package:foodiezone/screens/food_provider/widgets/admin_view_btn.dart';
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
                ontap: () {},
                icon: IconlyBold.profile,
                iconText: "Create Profile",
              ),
              FoodProviderViewButton(
                ontap: () {},
                icon: IconlyBold.bookmark,
                iconText: "Pending Orders",
              ),
            ],
          ),
          Row(
            children: [
              FoodProviderViewButton(
                ontap: () {},
                icon: IconlyBold.profile,
                iconText: "Confirm Orders",
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
