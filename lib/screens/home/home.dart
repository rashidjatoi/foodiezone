import 'package:flutter/material.dart';
import 'package:foodiezone/controllers/home_controller.dart';
import 'package:foodiezone/screens/home/home_screen.dart';
import 'package:foodiezone/screens/profile/profile_view.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    List<BottomNavigationBarItem> navigationItems = const [
      BottomNavigationBarItem(
        icon: Icon(IconlyLight.home),
        activeIcon: Icon(IconlyBold.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(IconlyLight.search),
        activeIcon: Icon(IconlyBold.search),
        label: "Search",
      ),
      BottomNavigationBarItem(
        icon: Icon(IconlyLight.bookmark),
        activeIcon: Icon(IconlyBold.bookmark),
        label: "Booking",
      ),
      BottomNavigationBarItem(
        icon: Icon(IconlyLight.profile),
        activeIcon: Icon(IconlyBold.profile),
        label: "Profile",
      ),
    ];

    var pagesList = const [HomeView(), HomeView(), HomeView(), ProfileView()];
    return Obx(() => Scaffold(
          body: pagesList[homeController.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            items: navigationItems,
            currentIndex: homeController.currentIndex.value,
            selectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            onTap: (value) {
              homeController.currentIndex.value = value;
            },
          ),
        ));
  }
}
