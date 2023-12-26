import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/screens/food_provider/add_food_items/add_food_items.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';

class FoodItemsView extends StatefulWidget {
  const FoodItemsView({super.key});

  @override
  State<FoodItemsView> createState() => _FoodItemsViewState();
}

class _FoodItemsViewState extends State<FoodItemsView> {
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
              scrollDirection: Axis.vertical,
              query: foodProviderDatabase,
              itemBuilder: (context, snapshot, animation, index) {
                if (snapshot.value != null) {
                  // final food = snapshot.child('food');
                  (snapshot.child('food').value.toString());
                  final imageUrl =
                      snapshot.child('food').child('imageUrl').value;

                  // final description =
                  //     snapshot.child('food').child('description').value;

                  final item =
                      snapshot.child('food').child('fooditemname').value;

                  final price = snapshot.child('food').child('price').value;

                  final address = snapshot.child('address').value;

                  debugPrint(snapshot.child('address').value.toString());

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: SizedBox(
                            height: 400,
                            width: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25),
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            imageUrl.toString(),
                                            errorListener: null,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Food Name: ",
                                            style: TextStyle(
                                              fontFamily: "DMsans-Medium",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            item.toString(),
                                            style: const TextStyle(
                                              fontFamily: "DMsans-Medium",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Price: ",
                                            style: TextStyle(
                                              fontFamily: "DMsans-Medium",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "\$ $price",
                                            style: const TextStyle(
                                              fontFamily: "DMsans-Medium",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Location: ",
                                            style: TextStyle(
                                              fontFamily: "DMsans-Medium",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            " $address",
                                            style: const TextStyle(
                                              fontFamily: "DMsans-Medium",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                } else {
                  return const Text('No Data');
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appcolor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(() => const AddFoodItemsView());
        },
      ),
    );
  }
}
