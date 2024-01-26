import 'package:flutter/material.dart';
import 'package:foodiezone/screens/order_details_user/delivery_driver_details.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class OrderDetailsUserDelivery extends StatefulWidget {
  const OrderDetailsUserDelivery({super.key});

  @override
  State<OrderDetailsUserDelivery> createState() =>
      _OrderDetailsUserDeliveryState();
}

class _OrderDetailsUserDeliveryState extends State<OrderDetailsUserDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery'),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream:
                firebaseDatabase.child(firebaseAuth.currentUser!.uid).onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<dynamic, dynamic>? map =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                if (map!['driver'] != null) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Get.to(() => DeliveryDriverDetailsForUser(
                                deliveryDriverId:
                                    map['driver']['uid'].toString()));
                          },
                          leading: const CircleAvatar(
                              child: Icon(IconlyLight.profile)),
                          title: Text(map['driver']['email'].toString()),
                          subtitle: const Text(
                            'Click to see details',
                            style: TextStyle(
                              color: Colors.black38,
                            ),
                          ),
                          trailing: const Icon(
                            IconlyLight.arrow_right,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Adjust as needed
                  children: [
                    Center(
                      child: Text('Order Pending'),
                    ),
                  ],
                );
              }

              return const Text('No delivery accepted yet');
            },
          )
        ],
      ),
    );
  }
}
