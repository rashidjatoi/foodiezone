import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/screens/profile/profile_details_view.dart';
import 'package:foodiezone/screens/theme/change_theme_view.dart';
import 'package:foodiezone/services/auth_services.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../widgets/custom_list_tile.dart';
import '../order_details_user/order_details_user_delivery.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              StreamBuilder(
                  stream: firebaseDatabase.onValue,
                  builder: (BuildContext context,
                      AsyncSnapshot<DatabaseEvent> snapshot) {
                    final user = firebaseAuth.currentUser;
                    final uid = user?.uid;

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 40,
                                    child: image != null
                                        ? ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: map[uid]["imageUrl"],
                                              fit: BoxFit.cover,
                                              width: 80,
                                              height: 80,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(), // Placeholder while loading
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Icon(IconlyBold.profile,
                                                      color: Colors
                                                          .white), // Error widget
                                            ),
                                          )
                                        : const Icon(
                                            IconlyBold.profile,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      map[uid]['username'].toString(),
                                      style: const TextStyle(
                                        fontFamily: "DMsans-Bold",
                                      ),
                                    ),
                                    Text(
                                      map[uid]['email'].toString(),
                                      style: const TextStyle(
                                        fontFamily: "DMsans-Medium",
                                        fontSize: 12,
                                        color: Colors.grey,
                                        overflow: TextOverflow.fade,
                                      ),
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'generalSetting'.tr,
                              style: const TextStyle(
                                fontFamily: "DMsans-Bold",
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Column(
                            children: [
                              CustomListTile(
                                tileText: 'myAccount'.tr,
                                tileIcon: IconlyLight.profile,
                                ontap: () {
                                  Map<String, dynamic> userData = {
                                    "email": map[uid]['email'],
                                    "username": map[uid]['username'],
                                    "uid": map[uid]['userId'],
                                    "date": map[uid]['date'],
                                    "gender": map[uid]['gender'],
                                    "cnic": map[uid]['cninc'],
                                    "phone": map[uid]['phone'],
                                    "role": map[uid]['role'],
                                    "address": map[uid]['address'],
                                  };
                                  Get.to(() =>
                                      ProfileDetailsView(userData: userData));
                                },
                              ),
                              // ListTile(
                              //   leading: const Icon(IconlyLight.profile),
                              //   onTap: map[uid]['role'] == "foodProvider"
                              //       ? () {
                              //           Get.to(
                              //               () => const FoodProviderAccount());
                              //         }
                              //       : null,
                              //   title: Text('foodProvider'.tr),
                              //   trailing: const Icon(Icons.arrow_forward_ios),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(12),
                              //       border: Border.all(
                              //         color: Colors.grey.shade300,
                              //       ),
                              //     ),
                              //     child: ListTile(
                              //       leading: const Icon(IconlyLight.profile),
                              //       onTap: map[uid]['role'] == "foodRider"
                              //           ? () {
                              //               Get.to(() =>
                              //                   const FoodDriverOrdersDetailsScreen());
                              //             }
                              //           : null,
                              //       title: Text('foodDrivier'.tr),
                              //       trailing:
                              //           const Icon(Icons.arrow_forward_ios),
                              //     ),
                              //   ),
                              // ),
                              CustomListTile(
                                tileText: 'theme'.tr,
                                tileIcon: Icons.dark_mode_outlined,
                                ontap: () {
                                  Get.to(() => const ChangeThemeScreen());
                                },
                              ),

                              CustomListTile(
                                tileText: 'Delivery Details',
                                tileIcon: Icons.delivery_dining,
                                ontap: () {
                                  if (map[uid]['role'] == "user") {
                                    Get.to(
                                        () => const OrderDetailsUserDelivery());
                                  } else {
                                    return;
                                  }
                                },
                              ),
                              CustomListTile(
                                tileText: 'SignOut'.tr,
                                tileIcon: IconlyLight.logout,
                                ontap: () {
                                  AuthServices.signOutUser().then((value) {
                                    Get.off(
                                      () => const LoginView(),
                                    );
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
