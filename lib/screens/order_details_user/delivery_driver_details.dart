import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/admin/user/widgets/custom_table_widget.dart';
import 'package:foodiezone/services/services_constants.dart';

class DeliveryDriverDetailsForUser extends StatefulWidget {
  final String deliveryDriverId;
  const DeliveryDriverDetailsForUser(
      {super.key, required this.deliveryDriverId});

  @override
  State<DeliveryDriverDetailsForUser> createState() =>
      _DeliveryDriverDetailsForUserState();
}

class _DeliveryDriverDetailsForUserState
    extends State<DeliveryDriverDetailsForUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Driver'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          StreamBuilder(
            stream: firebaseDatabase
                .child(widget.deliveryDriverId.toString())
                .onValue,
            builder:
                (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ],
                  ),
                );
              } else {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;

                print(map);

                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();

                return Column(
                  children: [
                    Table(
                      border: TableBorder.all(
                        color: Colors.grey.shade300,
                      ),
                      children: [
                        customTableWidget(
                          headingText: "Driver Name",
                          dataText: map['username'].toString(),
                        ),
                        customTableWidget(
                          headingText: "Email",
                          dataText: map['email'].toString(),
                        ),
                        customTableWidget(
                          headingText: "Gender",
                          dataText: map['gender'].toString(),
                        ),
                        customTableWidget(
                          headingText: "Phone",
                          dataText: map['phone'].toString(),
                        ),
                        customTableWidget(
                          headingText: "Address",
                          dataText: map['address'].toString(),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
