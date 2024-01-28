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
        title: const Text("Food Items"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: foodProviderDatabase
                  .child(firebaseAuth.currentUser!.uid)
                  .child("food"),
              itemBuilder: (context, snapshot, animation, index) {
                debugPrint(snapshot.value.toString());

                final price = snapshot.child('price').value;

                final foodImage = snapshot.child("imageUrl").value;

                final foodDescription = snapshot.child("description").value;

                final foodItemName = snapshot.child("fooditemname").value;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
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
                                            foodImage.toString(),
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
                                            foodItemName.toString(),
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
                                            "Description: ",
                                            style: TextStyle(
                                              fontFamily: "DMsans-Medium",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            truncateText(
                                                foodDescription.toString(), 6),
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
                  ),
                );
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
