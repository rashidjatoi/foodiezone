import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../admin/user/widgets/custom_table_widget.dart';

class FoodProviderOrderDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;
  const FoodProviderOrderDetailsScreen({super.key, required this.orderData});

  @override
  State<FoodProviderOrderDetailsScreen> createState() =>
      _FoodProviderOrderDetailsScreenState();
}

class _FoodProviderOrderDetailsScreenState
    extends State<FoodProviderOrderDetailsScreen> {
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
        title: const Text("Orders Details"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                StreamBuilder(
                    stream: firebaseDatabase.onValue,
                    builder: (BuildContext context,
                        AsyncSnapshot<DatabaseEvent> snapshot) {
                      final user = widget.orderData["uid"].toString();

                      final uid = user;

                      if (!snapshot.hasData) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ],
                          ),
                        );
                      } else {
                        Map<dynamic, dynamic> map =
                            snapshot.data!.snapshot.value as dynamic;

                        final image = map[uid]?["imageUrl"];

                        // print(map);
                        List<dynamic> list = [];
                        list.clear();
                        list = map.values.toList();

                        return Column(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: image,
                                height: 100,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Table(
                              border: TableBorder.all(
                                color: Colors.grey.shade300,
                              ),
                              children: [
                                customTableWidget(
                                  headingText: "Client Name",
                                  dataText: map[uid]['username'].toString(),
                                ),
                                customTableWidget(
                                  headingText: "Email",
                                  dataText: map[uid]['email'].toString(),
                                ),
                                customTableWidget(
                                  headingText: "Gender",
                                  dataText: map[uid]['gender'].toString(),
                                ),
                                customTableWidget(
                                  headingText: "Phone",
                                  dataText: map[uid]['phone'].toString(),
                                ),
                                customTableWidget(
                                  headingText: "Order",
                                  dataText: widget.orderData["foodItemName"]
                                      .toString(),
                                ),
                                customTableWidget(
                                  headingText: "Price",
                                  dataText:
                                      widget.orderData["foodPrice"].toString(),
                                ),
                                customTableWidget(
                                  headingText: "Address",
                                  dataText: map[uid]['address'].toString(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CustomButton(
                                btnText: 'WhatsApp Me',
                                btnColor: Colors.green,
                                btnMargin: 0,
                                ontap: () {
                                  openWhatsApp(map[uid]['phone'].toString());
                                },
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
