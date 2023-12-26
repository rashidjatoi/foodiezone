import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/food_driver_screen/details_view_food_driver.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class FoodDriverOrdersDetailsScreen extends StatefulWidget {
  const FoodDriverOrdersDetailsScreen({super.key});

  @override
  State<FoodDriverOrdersDetailsScreen> createState() =>
      _FoodDriverOrdersDetailsScreenState();
}

class _FoodDriverOrdersDetailsScreenState
    extends State<FoodDriverOrdersDetailsScreen> {
  final ref = FirebaseDatabase.instance.ref('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: firebaseDatabase,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.value != null) {
                    final order = snapshot.child('order').value;
                    final address = snapshot.child('address').value;
                    final phone = snapshot.child('phone').value;
                    final imageUrl = snapshot.child('imageUrl').value;
                    final email = snapshot.child('email').value;
                    final name = snapshot.child('username').value;
                    final foodPrice =
                        snapshot.child('order').child('foodPrice').value;
                    // print(snapshot.child('order').value);

                    if (order != null) {
                      final foodImage =
                          snapshot.child('order').child('foodImage').value;
                      final foodItemName =
                          snapshot.child('order').child('foodItemName').value;

                      return CupertinoButton(
                        onPressed: () {
                          Map<String, dynamic> userOrderDetails = {
                            "address": address,
                            "phone": phone,
                            "imageUrl": imageUrl,
                            "email": email,
                            "usernmae": name,
                            "foodImage": foodImage,
                            "foodItem": foodItemName,
                            "foodPrice": foodPrice,
                          };

                          Get.to(
                            () => FoodDriverUserOrderDetailsView(
                              ordeDetails: userOrderDetails,
                            ),
                          );
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        child: foodImage != null
                                            ? ClipOval(
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      foodImage.toString(),
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                  height: 100,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                    IconlyBold.profile,
                                                    color: Colors.white,
                                                  ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        foodItemName.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: "DMSans Bold",
                                        ),
                                      ),
                                      // You can add more UI elements here
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Text('');
                    }
                  } else {
                    return const Text('');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
