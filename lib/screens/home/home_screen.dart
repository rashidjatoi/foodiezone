import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/screens/food_provider_details_to_client/food_provider_details_to_client.dart';
import 'package:foodiezone/screens/help/help_view.dart';
import 'package:foodiezone/screens/profile/profile_view.dart';
import 'package:foodiezone/screens/search_food/search_food_screen.dart';
import 'package:foodiezone/screens/user_order_view/user_order_view.dart';
import 'package:foodiezone/services/auth_services.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../lanugage_screen/chage_language_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String truncateText(String text, int maxWords) {
    List<String> words = text.split(' ');
    if (words.length > maxWords) {
      words = words.sublist(0, maxWords);
      return '${words.join(' ')}...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'foodieZone'.tr,
          style: const TextStyle(
            fontFamily: "DMSans Medium",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SearchFoodScreen());
            },
            icon: const Icon(
              IconlyLight.search,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const ChnageLanguageScreen());
            },
            icon: const Icon(
              Icons.language,
            ),
          )
        ],
      ),
      drawer: drawerMethod(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const AutoScrollableListView(),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'foodProvider'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "DMSans Bold",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'seeAll'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: appcolor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: foodProviderDatabase,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.value != null) {
                    final price = snapshot.child('food').child('price').value;
                    final userId = snapshot.child('userId').value;

                    final userImage = snapshot.child('imageUrl').value;
                    final address = snapshot.child('address').value;
                    final phone = snapshot.child('phone').value;

                    final foodImage =
                        snapshot.child('food').child("imageUrl").value;

                    final foodDescription =
                        snapshot.child('food').child("description").value;

                    final foodItemName =
                        snapshot.child('food').child("fooditemname").value;
                    final providerName = snapshot.child('username').value;
                    final email = snapshot.child('email').value;

                    final Map<String, dynamic> userData = {
                      "username": providerName,
                      "address": address,
                      "phone": phone,
                      "userImage": userImage,
                      "userId": userId,
                      "email": email,
                      "foodPrice": price,
                      "foodImage": foodImage,
                      "foodDescription": foodDescription,
                      "foodItemName": foodItemName
                    };
                    final image = snapshot.child('imageUrl').value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => FoodProviderDetailsToClientView(
                              userData: userData,
                            ),
                          );
                        },
                        child: Container(
                          height: 120,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        image != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot
                                                      .child('imageUrl')
                                                      .value
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                  height: 100,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(
                                                          IconlyBold.profile,
                                                          color: Colors.white),
                                                ),
                                              )
                                            : const Icon(
                                                IconlyBold.profile,
                                                color: Colors.white,
                                              ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          providerName.toString(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontFamily: "DMSans Bold",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(truncateText(
                                                address.toString(), 4)),
                                          ],
                                        ),
                                        Text(phone.toString()),
                                      ],
                                    )
                                  ],
                                ),
                                Icon(
                                  IconlyLight.arrow_right,
                                  color: Colors.grey.shade400,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Text('No Data');
                  }
                },
              ),
            ),
          ],
        ),
      ),
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
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('home'.tr),
              leading: const Icon(IconlyBold.home),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Orders'.tr),
              leading: const Icon(IconlyBold.heart),
              onTap: () {
                Get.to(() => const UserOrderView());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Chat'.tr),
              leading: const Icon(IconlyBold.chat),
              onTap: () {
                Get.to(() => const HelpDeskView());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Profile'.tr),
              leading: const Icon(IconlyBold.profile),
              onTap: () {
                Get.to(() => const ProfileView());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('SignOut'.tr),
              leading: const Icon(IconlyBold.logout),
              onTap: () {
                AuthServices.signOutUser().then((value) {
                  Get.offAll(
                    () => const LoginView(),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AutoScrollableListView extends StatefulWidget {
  const AutoScrollableListView({super.key});

  @override
  State<AutoScrollableListView> createState() => _AutoScrollableListViewState();
}

class _AutoScrollableListViewState extends State<AutoScrollableListView> {
  List<String> imagesPath = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
    "assets/images/5.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: imagesPath.length,
        options: CarouselOptions(
          height: 200,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
        ),
        itemBuilder: (context, index, realIndex) {
          return Container(
            height: 200,
            width: 360,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: appcolor.withOpacity(0.11),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagesPath[index].toString()),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
