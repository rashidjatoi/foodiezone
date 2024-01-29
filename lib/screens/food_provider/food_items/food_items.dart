import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/food_provider/edit_food_item/edit_food_item.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

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
                if (snapshot.value != null) {
                  debugPrint(snapshot.value.toString());

                  final price = snapshot.child('price').value;

                  final foodImage = snapshot.child("imageUrl").value;

                  final foodDescription = snapshot.child("description").value;

                  final foodItemName = snapshot.child("fooditemname").value;
                  final foodId = snapshot.child("foodId").value;

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: foodImage.toString(),
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 120,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        IconlyBold.image,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            foodItemName.toString(),
                                            style: const TextStyle(
                                              fontFamily: "DMSans Medium",
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            truncateText(
                                                foodDescription.toString(), 3),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Rs: ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "DMSans Medium",
                                            ),
                                          ),
                                          Text(price.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Map<String, dynamic> data = {
                                        "foodImage": foodImage,
                                        "price": price,
                                        "foodDescription": foodDescription,
                                        "foodItemName": foodItemName,
                                        "foodId": foodId,
                                      };
                                      Get.to(
                                          () => EditFoodItemsView(data: data));
                                    },
                                    icon: const Icon(IconlyLight.edit),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await foodProviderDatabase
                                          .child(firebaseAuth.currentUser!.uid)
                                          .child('food')
                                          .child(foodId.toString())
                                          .remove();
                                    },
                                    icon: const Icon(
                                      IconlyLight.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Text('No Items Added');
              },
            ),
          ),
        ],
      ),
    );
  }
}
