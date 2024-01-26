import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../food_details_order/food_details_order.dart';

class FoodProviderDetailsToClientView extends StatefulWidget {
  final Map<String, dynamic> userData;

  const FoodProviderDetailsToClientView({super.key, required this.userData});

  @override
  State<FoodProviderDetailsToClientView> createState() =>
      _FoodProviderDetailsToClientViewState();
}

class _FoodProviderDetailsToClientViewState
    extends State<FoodProviderDetailsToClientView> {
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
        title: Text(widget.userData['username']),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text(
              "Food Items",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FirebaseAnimatedList(
                query: foodProviderDatabase
                    .child(widget.userData["userId"])
                    .child("food"),
                itemBuilder: (context, snapshot, animation, index) {
                  debugPrint(snapshot.value.toString());

                  final price = snapshot.child('price').value;
                  final userId = snapshot.child('userId').value;

                  final foodImage = snapshot.child("imageUrl").value;

                  final foodDescription = snapshot.child("description").value;

                  final foodItemName = snapshot.child("fooditemname").value;

                  return Card(
                    color: Colors.white,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Map<String, dynamic> foodDetails = {
                            "foodPrice": price,
                            "foodImage": foodImage,
                            "foodDescription": foodDescription,
                            "foodItemName": foodItemName,
                            "userId": userId,
                          };

                          Get.to(() => FoodDetailsOrderView(
                                foodDetails: foodDetails,
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl: foodImage.toString(),
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      IconlyBold.profile,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          foodItemName.toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "DMSans Bold",
                                          ),
                                        ),
                                        Text(
                                          truncateText(
                                            foodDescription.toString(),
                                            4,
                                          ),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$$price ",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: appcolor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const CircleAvatar(
                                  radius: 18,
                                  backgroundColor: appcolor,
                                  child: Icon(
                                    IconlyLight.heart,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
