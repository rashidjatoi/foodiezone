import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/admin/user/widgets/custom_table_widget.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

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
  void openWhatsApp(String phoneNumber) async {
    String whatsappUrl = "https://wa.me/$phoneNumber";

    if (await launchUrl(Uri.parse(whatsappUrl))) {
      await canLaunchUrl(Uri.parse(whatsappUrl));
    } else {
      debugPrint(
          'Could not launch WhatsApp. Make sure the app is installed on the device.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Thanks for the order in the FoodieZone app!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: firebaseDatabase
                  .child(widget.deliveryDriverId.toString())
                  .onValue,
              builder: (BuildContext context,
                  AsyncSnapshot<DatabaseEvent> snapshot) {
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
                      const SizedBox(height: 15),
                      CustomButton(
                        btnText: 'WhatsApp Me',
                        btnMargin: 0,
                        ontap: () {
                          openWhatsApp(map['phone'].toString());
                        },
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
