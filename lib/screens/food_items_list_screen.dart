import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/food_provider_details_to_client/food_provider_details_to_client.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class FoodItemListScreen extends StatefulWidget {
  const FoodItemListScreen({super.key});

  @override
  State<FoodItemListScreen> createState() => _FoodItemListScreenState();
}

class _FoodItemListScreenState extends State<FoodItemListScreen> {
  bool btnLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Items"),
      ),
      body: Column(
        children: [
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
                                                  const Icon(IconlyBold.profile,
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
                                      Text(address.toString()),
                                    ],
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
    );
  }
}
