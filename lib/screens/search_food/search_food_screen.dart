import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../food_details_order/item_food_details.dart';

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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search Item',
                  prefixIcon: Icon(IconlyLight.search),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    searchController.text = value.toString();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: foodProviderDatabase.onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: SizedBox(
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  Map<dynamic, dynamic>? map =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                  if (map == null) {
                    return const SizedBox();
                  }

                  List<dynamic> list = map.values.toList();
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var foodProvider = list[index];
                      var foods = foodProvider.containsKey('food') &&
                              foodProvider['food'] is Map<dynamic, dynamic>
                          ? foodProvider['food'] as Map<dynamic, dynamic>
                          : null;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: foods!.length,
                              itemBuilder: (context, foodIndex) {
                                var foodItem = foods.values.toList()[foodIndex];

                                if (foodItem['fooditemname']
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                      searchController.text
                                          .toString()
                                          .toLowerCase(),
                                    )) {
                                  return InkWell(
                                    onTap: () {
                                      final Map<String, dynamic> foodDetails = {
                                        "username": foodProvider['username'],
                                        "foodPrice": foodItem['price'],
                                        "foodImage": foodItem['imageUrl'],
                                        "foodDescription":
                                            foodItem['description'],
                                        "foodItemName": foodItem['fooditemname']
                                      };

                                      Get.to(
                                        ItemDetailsView(
                                          foodDetails: foodDetails,
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            )),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        foodItem['imageUrl']
                                                            .toString(),
                                                    fit: BoxFit.cover,
                                                    height: 120,
                                                    width: 120,
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
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
                                                          foodItem[
                                                              'fooditemname'],
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                "DMSans Medium",
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'By: ',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                "DMSans Medium",
                                                          ),
                                                        ),
                                                        Text(
                                                          foodProvider[
                                                              'username'],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Rs: ',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                "DMSans Medium",
                                                          ),
                                                        ),
                                                        Text(foodItem['price']),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
