import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/admin/user/widgets/custom_table_widget.dart';
import 'package:foodiezone/screens/food_driver_screen/food_driver_food_provider_screen.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:foodiezone/utils/utils.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodDriverUserOrderDetailsView extends StatefulWidget {
  final Map<String, dynamic> orderData;

  const FoodDriverUserOrderDetailsView({super.key, required this.orderData});

  @override
  State<FoodDriverUserOrderDetailsView> createState() =>
      _FoodDriverUserOrderDetailsViewState();
}

class _FoodDriverUserOrderDetailsViewState
    extends State<FoodDriverUserOrderDetailsView> {
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
                    final user = widget.orderData["providerUserId"].toString();

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

                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();

                      return Column(
                        children: [
                          image != null && image.isNotEmpty
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: image,
                                    height: 100,
                                  ),
                                )
                              : const ClipOval(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      IconlyLight.profile,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Table(
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
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              btnText: 'WhatsApp Me',
                              btnColor: Colors.green,
                              btnMargin: 0,
                              ontap: () {
                                openWhatsApp(map[uid]['phone'].toString());
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 5),
                CustomButton(
                  btnText: 'Food Provider Details',
                  btnRadius: 6,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDriverFoodPrviderScreen(
                          userId: widget.orderData["uid"].toString(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  btnText: 'Pick Order',
                  btnRadius: 6,
                  ontap: () async {
                    final String driverUserId = firebaseAuth.currentUser!.uid;
                    final String driverUserEmail =
                        firebaseAuth.currentUser!.email.toString();

                    await firebaseDatabase
                        .child(uid.toString())
                        .child('driver')
                        .set(
                      {
                        "uid": driverUserId.toString(),
                        "email": driverUserEmail.toString(),
                      },
                    ).then((value) => Utils.showToast(
                              message: 'Order Placed',
                              bgColor: Colors.green,
                              textColor: Colors.white,
                            ));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
