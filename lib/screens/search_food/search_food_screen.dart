import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodiezone/screens/food_details_order/food_details_order.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class SearchFoodScreen extends StatefulWidget {
  const SearchFoodScreen({super.key});

  @override
  State<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Food'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search Item',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchController.text = value.toString();
                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              // scrollDirection: Axis.vertical,
              query: foodProviderDatabase,
              itemBuilder: (context, snapshot, animation, index) {
                if (snapshot.value != null) {
                  final price = snapshot.child('food').child('price').value;
                  // final userId = snapshot.child('userId').value;

                  // final userImage = snapshot.child('imageUrl').value;
                  final address = snapshot.child('address').value;
                  // final phone = snapshot.child('phone').value;

                  // debugPrint(snapshot.value.toString());

                  final foodImage =
                      snapshot.child('food').child("imageUrl").value;

                  final foodDescription =
                      snapshot.child('food').child("description").value;

                  final foodItemName =
                      snapshot.child('food').child("fooditemname").value;
                  // final providerName = snapshot.child('username').value;
                  // final email = snapshot.child('email').value;
                  // print(foodItemName);

                  // final Map<String, dynamic> userData = {
                  //   "username": providerName,
                  //   "address": address,
                  //   "phone": phone,
                  //   "userImage": userImage,
                  //   "userId": userId,
                  //   "email": email,
                  //   "foodPrice": price,
                  //   "foodImage": foodImage,
                  //   "foodDescription": foodDescription,
                  //   "foodItemName": foodItemName
                  // };
                  final image = snapshot.child('imageUrl').value;

                  if (foodItemName.toString().toLowerCase().contains(
                        searchController.text.toString().toLowerCase(),
                      )) {
                    return CupertinoButton(
                      onPressed: () {
                        Map<String, dynamic> foodDetails = {
                          "foodPrice": price,
                          "foodImage": foodImage,
                          "foodDescription": foodDescription,
                          "foodItemName": foodItemName,
                        };

                        Get.to(() => FoodDetailsOrderView(
                              foodDetails: foodDetails,
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
                                                imageUrl: foodImage.toString(),
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
                                      foodItemName.toString(),
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
                    return const SizedBox();
                  }
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
