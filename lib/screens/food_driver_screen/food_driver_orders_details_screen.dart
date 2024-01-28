import 'package:flutter/material.dart';
import 'package:foodiezone/screens/food_driver_screen/details_view_food_driver.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';

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
                        final foodPrice = foodProvider["foodPrice"];
                        final foodDescription = foodProvider["foodDescription"];
                        final foodItemName = foodProvider["foodItemName"];
                        final foodImage = foodProvider["foodImage"];
                        final userId = foodProvider["userId"];
                        final foodProviderUserId =
                            foodProvider["currentUserId"];

                        return GestureDetector(
                          onTap: () {
                            Map<String, dynamic> orderData = {
                              "foodItemName": foodItemName,
                              "foodPrice": foodPrice,
                              "foodDescription": foodDescription,
                              "uid": userId,
                              "providerUserId": foodProviderUserId,
                            };

                            Get.to(
                              () => FoodDriverUserOrderDetailsView(
                                orderData: orderData,
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: ClipOval(
                                      child: Image.network(
                                        foodImage,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(foodItemName),
                                    subtitle: Text(
                                      foodDescription,
                                      maxLines: 1,
                                    ),
                                    trailing: Text(
                                      'Rs: $foodPrice',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
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
