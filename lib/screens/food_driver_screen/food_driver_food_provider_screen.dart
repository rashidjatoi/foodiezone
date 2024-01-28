import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/admin/user/widgets/custom_table_widget.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodDriverFoodPrviderScreen extends StatefulWidget {
  final String userId;
  const FoodDriverFoodPrviderScreen({super.key, required this.userId});

  @override
  State<FoodDriverFoodPrviderScreen> createState() =>
      _FoodDriverFoodPrviderScreenState();
}

class _FoodDriverFoodPrviderScreenState
    extends State<FoodDriverFoodPrviderScreen> {
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
        title: const Text('Food Provider'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  foodProviderDatabase.child(widget.userId.toString()).onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data!.snapshot.value);
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;

                  final image = map['imageUrl'];
                  final email = map['email'];
                  final username = map['username'];
                  final phone = map['phone'];
                  final address = map['address'];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.grey.shade300,
                          ),
                          children: [
                            customTableWidget(
                              headingText: "Provider Name",
                              dataText: username.toString(),
                            ),
                            customTableWidget(
                              headingText: "Email",
                              dataText: email.toString(),
                            ),
                            customTableWidget(
                              headingText: "Phone",
                              dataText: phone.toString(),
                            ),
                            customTableWidget(
                              headingText: "Address",
                              dataText: address.toString(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomButton(
                          btnText: 'WhatsApp Me',
                          btnMargin: 0,
                          ontap: () {
                            openWhatsApp(map['phone'].toString());
                          },
                        ),
                      )
                    ],
                  );
                }
                return const Text('No Data');
              },
            ),
          )
        ],
      ),
    );
  }
}
