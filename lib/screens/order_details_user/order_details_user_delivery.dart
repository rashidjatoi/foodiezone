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
                if (map!['driver']['email'] != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Get.to(() => DeliveryDriverDetailsForUser(
                              deliveryDriverId:
                                  map['driver']['uid'].toString()));
                        },
                        leading: const Icon(IconlyLight.profile),
                        title: Text(map['driver']['email'].toString()),
                      ),
                    ),
                  );
                }

                return const Text('No delivery accepted yet');
              }

              return const Text('No delivery accepted yet');
            },
          )
        ],
      ),
    );
  }
}
