import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/provider/home_provider.dart';
import 'package:foodiezone/screens/bottom_navigation/custom_bottom_navigation_btn.dart';
import 'package:foodiezone/screens/home/home_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../user_order_view/user_order_view.dart';
import '../profile/profile_view.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  @override
  Widget build(BuildContext context) {
    debugPrint("build");

    var pagesList = [
      const HomeView(),
      const UserOrderView(),
      // const HelpDeskView(),
      const ProfileView()
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
                    ? Colors.grey
                    : customThemeColor,
                blurRadius:
                    Theme.of(context).brightness == Brightness.dark ? 9.3 : 0.9,
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
                builder: (context, value, child) =>
                    CustomBottomNavigationButton(
                      selectedIcon: IconlyBold.heart,
                      icon: IconlyLight.heart,
                      onPressed: () {
                        value.changeIndex(1);
                      },
                      isSelected: value.currentIndex == 1,
                    )),
            // Consumer<HomeProvider>(
            //   builder: (context, value, child) => CustomBottomNavigationButton(
            //     selectedIcon: IconlyBold.chat,
            //     icon: IconlyLight.chat,
            //     onPressed: () {
            //       value.changeIndex(2);
            //     },
            //     isSelected: value.currentIndex == 2,
            //   ),
            // ),
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
