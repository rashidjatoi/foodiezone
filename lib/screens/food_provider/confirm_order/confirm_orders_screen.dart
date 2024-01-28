import 'package:flutter/material.dart';
import 'package:foodiezone/screens/food_provider/order_details/foodprovider_order_details_screen.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: foodProviderDatabase.onValue,
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

                        if (foodProvider['userId'] ==
                            firebaseAuth.currentUser!.uid) {
                          var foods = foodProvider['order'];

                          if (foods == null || foods.isEmpty) {
                            return const Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(''),
                              ),
                            );
                          }

                          if (foods is Map) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5,
                              ),
                              child: Column(
                                children: foods.entries.map((foodEntry) {
                                  var foodItem =
                                      foodEntry.value as Map<dynamic, dynamic>;

                                  return GestureDetector(
                                    onTap: () {
                                      Map<String, dynamic> orderData = {
                                        "foodItemName":
                                            foodItem['foodItemName'],
                                        "foodPrice": foodItem['foodPrice'],
                                        "uid": foodItem["currentUserId"],
                                      };

                                      Get.to(
                                        () => FoodProviderOrderDetailsScreen(
                                          orderData: orderData,
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: ListTile(
                                            leading: Image.network(
                                              foodItem['foodImage'],
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                            title:
                                                Text(foodItem['foodItemName']),
                                            subtitle: Text(
                                                foodItem['foodDescription']),
                                            trailing: Text(
                                              'Rs: ${foodItem['foodPrice']}',
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }

                          return const Text('');
                        } else {
                          return const Text('');
                        }
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
