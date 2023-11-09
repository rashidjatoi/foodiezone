import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/screens/favourite_view/add_to_favourite_view.dart';
import 'package:foodiezone/screens/food_provider/food_provider_account/food_provider_account.dart';
import 'package:foodiezone/screens/help/help_view.dart';
import 'package:foodiezone/screens/profile/profile_view.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "FoodieZone",
          style: TextStyle(
            fontFamily: "DMSans Medium",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              IconlyLight.search,
            ),
          )
        ],
      ),
      drawer: drawerMethod(context),
      body: const Column(),
    );
  }

// Drawer
  Drawer drawerMethod(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: appcolor,
            ),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: Icon(
                        IconlyBold.profile,
                        size: 40,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? customThemeColor
                            : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    firebaseAuth.currentUser!.email.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(IconlyBold.home),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Favourite'),
            leading: const Icon(IconlyBold.heart),
            onTap: () {
              Get.to(() => const AddToFavouriteView());
            },
          ),
          ListTile(
            title: const Text('Chat'),
            leading: const Icon(IconlyBold.chat),
            onTap: () {
              Get.to(() => const HelpDeskView());
            },
          ),
          ListTile(
            title: const Text('Food Provider'),
            leading: const Icon(IconlyBold.work),
            onTap: () {
              Get.to(() => const FoodProviderAccount());
            },
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(IconlyBold.profile),
            onTap: () {
              Get.to(() => const ProfileView());
            },
          ),
        ],
      ),
    );
  }
}
