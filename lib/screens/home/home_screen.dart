import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/screens/food_driver_screen/food_provider_screen.dart';
import 'package:foodiezone/screens/search_food/search_food_screen.dart';
import 'package:foodiezone/screens/user_order_view/user_order_view.dart';
import 'package:foodiezone/screens/food_provider/food_provider_account/food_provider_account.dart';
import 'package:foodiezone/screens/food_provider_details_to_client/food_provider_details_to_client.dart';
import 'package:foodiezone/screens/help/help_view.dart';
import 'package:foodiezone/screens/profile/profile_view.dart';
import 'package:foodiezone/services/auth_services.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconly/iconly.dart';
import '../lanugage_screen/chage_language_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> imagesPath = [
    "assets/images/real/apple_pie.jpg",
    "assets/images/real/bakery.jpg",
    "assets/images/real/breakfast.jpg",
    "assets/images/real/coffee.jpg",
    "assets/images/real/hamburger3.jpg",
  ];

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
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                itemCount: imagesPath.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    width: 360,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: appcolor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(
                          imagesPath[index].toString(),
                        ),
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
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Food Providers",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "DMSans Bold",
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "DMSans Medium",
                    color: appcolor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: FirebaseAnimatedList(
                // scrollDirection: Axis.vertical,
                query: foodProviderDatabase,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.value != null) {
                    final price = snapshot.child('food').child('price').value;
                    final userId = snapshot.child('userId').value;

                    final userImage = snapshot.child('imageUrl').value;
                    final address = snapshot.child('address').value;
                    final phone = snapshot.child('phone').value;

                    // debugPrint(snapshot.value.toString());

                    final foodImage =
                        snapshot.child('food').child("imageUrl").value;

                    final foodDescription =
                        snapshot.child('food').child("description").value;

                    final foodItemName =
                        snapshot.child('food').child("fooditemname").value;
                    final providerName = snapshot.child('username').value;
                    final email = snapshot.child('email').value;
                    // print(foodItemName);

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
                    return CupertinoButton(
                      onPressed: () {
                        Get.to(() => FoodProviderDetailsToClientView(
                              userData: userData,
                            ));
                      },
                      padding: const EdgeInsets.all(0),
                      child: Card(
                        child: Container(
                          height: 120,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      child: image != null
                                          ? ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot
                                                    .child('imageUrl')
                                                    .value
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(), // Placeholder while loading
                                                errorWidget: (context, url,
                                                        error) =>
                                                    const Icon(
                                                        IconlyBold.profile,
                                                        color: Colors
                                                            .white), // Error widget
                                              ),
                                            )
                                          : const Icon(
                                              IconlyBold.profile,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      providerName.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: "DMSans Bold",
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // const Icon(IconlyBold.location),
                                        Text(address.toString()),
                                      ],
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.black,
                                        size: 4,
                                      ),
                                      onRatingUpdate: (rating) {
                                        debugPrint(rating.toString());
                                      },
                                    ),
                                  ],
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Home'),
              leading: const Icon(IconlyBold.home),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Orders'),
              leading: const Icon(IconlyBold.heart),
              onTap: () {
                Get.to(() => const UserOrderView());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Chat'),
              leading: const Icon(IconlyBold.chat),
              onTap: () {
                Get.to(() => const HelpDeskView());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Profile'),
              leading: const Icon(IconlyBold.profile),
              onTap: () {
                Get.to(() => const ProfileView());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Sign Out'),
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

// Custom Header Widget
class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Search Hostels in any \nlocation",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "DMsans-Bold",
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          // const SizedBox(height: 5),
          CupertinoButton(
            onPressed: () {},
            child: Container(
              width: 120,
              height: 50,
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "Find Hostels",
                  style: TextStyle(
                    fontFamily: "DMsans-Medium",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
