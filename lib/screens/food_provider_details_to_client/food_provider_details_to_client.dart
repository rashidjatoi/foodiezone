import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
            Card(
              child: SizedBox(
                height: 140,
                child: Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.userData['userImage'],
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(
                          IconlyBold.profile,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.userData['username'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "DMSans Bold",
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.userData['address']),
                            Text(widget.userData['phone']),
                          ],
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
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
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              "Popular",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "DMSans Bold",
              ),
            ),
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

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
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
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: foodImage.toString(),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                IconlyBold.profile,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                foodItemName.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: "DMSans Bold",
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    truncateText(
                                      foodDescription.toString(),
                                      4,
                                    ),
                                  ),
                                  Text(
                                    "\$$price ",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
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
