import 'package:flutter/material.dart';
import 'package:foodiezone/services/services_constants.dart';

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
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var foodProvider = list[index];
                      var foods =
                          foodProvider['order'] as Map<dynamic, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5,
                        ),
                        child: Column(
                          children: foods.entries.map((foodEntry) {
                            var foodItem =
                                foodEntry.value as Map<dynamic, dynamic>;

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              child: ListTile(
                                leading: Image.network(
                                  foodItem['foodImage'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(foodItem['foodItemName']),
                                subtitle: Text(foodItem['foodDescription']),
                                trailing: Text('\$${foodItem['foodPrice']}'),
                                onTap: () {
                                  // Handle the onTap action here if needed
                                },
                              ),
                            );
                          }).toList(),
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
