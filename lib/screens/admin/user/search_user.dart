import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/screens/admin/user/edit_users_view.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../services/services_constants.dart';

class SearchUserView extends StatefulWidget {
  const SearchUserView({super.key});

  @override
  State<SearchUserView> createState() => _SearchUserViewState();
}

class _SearchUserViewState extends State<SearchUserView> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        elevation: 0.8,
      ),
      body: Column(
        children: [
          // Sizebox
          const SizedBox(height: 10),

          // Search TextField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: "Enter Email Address",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Sizebox
          const SizedBox(height: 10),

          // CustomButton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomButton(
                btnText: "Search",
                ontap: () {
                  setState(() {});
                }),
          ),
          StreamBuilder(
            stream: hostelDatabase.onValue,
            builder:
                (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              } else {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;

                // print(map);
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final userData = list[index] as Map<dynamic, dynamic>;

                      if (searchController.text
                          .toString()
                          .contains(userData['email'])) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              onTap: () {
                                Map<String, dynamic> data = {
                                  "email": userData['email'],
                                  "username": userData['username'],
                                  "uid": userData['userId'],
                                  "date": userData['date'],
                                  "gender": userData['gender'],
                                  "cnic": userData['cninc'],
                                  "phone": userData['phone'],
                                  "role": userData['role'],
                                };

                                Get.to(
                                  () => EditUsersView(data: data),
                                );
                              },
                              leading: const CircleAvatar(
                                backgroundColor: Colors.black,
                                child: Icon(
                                  IconlyBold.profile,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                userData['username'],
                                style: const TextStyle(
                                  fontFamily: "DMsans-Medium",
                                ),
                              ),
                              subtitle: Text(userData['email']),
                              trailing: const Icon(IconlyLight.arrow_right),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
