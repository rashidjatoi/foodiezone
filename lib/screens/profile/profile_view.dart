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
import '../help/help_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
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
                                CircleAvatar(
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
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "General Settings",
                              style: TextStyle(
                                fontFamily: "DMsans-Bold",
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Column(
                            children: [
                              CustomListTile(
                                tileText: "My Account",
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
                              CustomListTile(
                                tileText: "Payment methods",
                                tileIcon: IconlyLight.setting,
                                ontap: () {},
                              ),
                              CustomListTile(
                                tileText: "My Address",
                                tileIcon: IconlyLight.location,
                                ontap: () {},
                              ),
                              CustomListTile(
                                tileText: "Contact Preferences",
                                tileIcon: IconlyLight.chat,
                                ontap: () {},
                              ),
                              CustomListTile(
                                tileText: "Help",
                                tileIcon: IconlyLight.info_square,
                                ontap: () {
                                  Get.to(() => const HelpDeskView());
                                },
                              ),
                              CustomListTile(
                                tileText: "Theme",
                                tileIcon: Icons.dark_mode_outlined,
                                ontap: () {
                                  Get.to(() => const ChangeThemeScreen());
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.change_circle_outlined,
                                ),
                                onTap: map[uid]['role'] == "hosteler"
                                    ? () {
                                        // Get.to(() => const HostelOwnerView());
                                      }
                                    : null,
                                title: const Text("Switch Mode"),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                              CustomListTile(
                                tileText: "Sign Out",
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
