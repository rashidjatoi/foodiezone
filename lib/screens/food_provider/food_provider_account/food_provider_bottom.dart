import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/provider/home_provider.dart';
import 'package:foodiezone/screens/bottom_navigation/custom_bottom_navigation_btn.dart';
import 'package:foodiezone/screens/profile/profile_view.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../food_items/food_items.dart';
import '../food_provider_account/food_provider_account.dart';

class FoodBottomNavigationBarView extends StatefulWidget {
  const FoodBottomNavigationBarView({super.key});

  @override
  State<FoodBottomNavigationBarView> createState() =>
      _FoodBottomNavigationBarViewState();
}

class _FoodBottomNavigationBarViewState
    extends State<FoodBottomNavigationBarView> {
  @override
  Widget build(BuildContext context) {
    debugPrint("build");

    var pagesList = [
      const FoodProviderAccount(),
      const FoodItemsView(),
      const ProfileView(),
    ];

    return Scaffold(
      extendBody: true,
      body: Consumer<HomeProvider>(
          builder: (context, value, child) => pagesList[value.currentIndex]),
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? customThemeColor
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? customThemeColor
                    : customThemeColor,
                blurRadius:
                    Theme.of(context).brightness == Brightness.dark ? 9.3 : 9.3,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<HomeProvider>(
              builder: (context, value, child) => CustomBottomNavigationButton(
                selectedIcon: IconlyBold.home,
                icon: IconlyLight.home,
                onPressed: () {
                  value.changeIndex(0);
                },
                isSelected: value.currentIndex == 0,
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, value, child) => CustomBottomNavigationButton(
                selectedIcon: Icons.food_bank,
                icon: Icons.food_bank_outlined,
                onPressed: () {
                  value.changeIndex(1);
                },
                isSelected: value.currentIndex == 1,
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, value, child) => CustomBottomNavigationButton(
                selectedIcon: IconlyBold.profile,
                icon: IconlyLight.profile,
                onPressed: () {
                  value.changeIndex(2);
                },
                isSelected: value.currentIndex == 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
