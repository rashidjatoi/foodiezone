import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/food_driver_screen/details_view_food_driver.dart';
import 'package:foodiezone/screens/food_provider/order_details/foodprovider_order_details_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders Details"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: orderDatabase.onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  Map<dynamic, dynamic>? map =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

                  // print(map);

                  if (map == null || map.isEmpty) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                  List<dynamic> list = map.values.toList();

                  return ListView.builder(
                    itemCount: list.isEmpty ? 1 : list.length,
                    itemBuilder: (context, index) {
                      if (list.isEmpty) {
                        return const Center(
                          child: Text('No orders found'),
                        );
                      } else {
                        var foodProvider = list[index];
                        print(foodProvider);
                        final foodPrice = foodProvider["foodPrice"];
                        final foodDescription = foodProvider["foodDescription"];
                        final foodItemName = foodProvider["foodItemName"];
                        final currentUserId = foodProvider["currentUserId"];
                        final foodImage = foodProvider["foodImage"];
                        final userId = foodProvider["userId"];
                        var foods = foodProvider['foodPrice'];

                        return GestureDetector(
                          onTap: () {
                            Map<String, dynamic> orderData = {
                              "foodItemName": foodItemName,
                              "foodPrice": foodPrice,
                              "foodDescription": foodDescription,
                              "uid": userId,
                            };

                            Get.to(
                              () => FoodDriverUserOrderDetailsView(
                                orderData: orderData,
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.network(
                                  foodImage,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(foodItemName),
                                subtitle: Text(foodDescription),
                                trailing: Text('\$${foodPrice}'),
                              ),
                            ],
                          ),
                        );
                      }
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
