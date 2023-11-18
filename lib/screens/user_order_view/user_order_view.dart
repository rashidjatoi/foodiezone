import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/models/hostel_model.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:iconly/iconly.dart';

class UserOrderView extends StatefulWidget {
  const UserOrderView({super.key});

  @override
  State<UserOrderView> createState() => _UserOrderViewState();
}

class _UserOrderViewState extends State<UserOrderView> {
  final ref = FirebaseDatabase.instance.ref('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: ref.onValue,
              builder: (BuildContext context,
                  AsyncSnapshot<DatabaseEvent> snapshot) {
                final user = firebaseAuth.currentUser;
                final uid = user?.uid;

                if (!snapshot.hasData) {
                  return const Center(
                    child: SizedBox(
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;

                  // print(map);
                  List<dynamic> list = [];
                  list.clear();
                  list = map.values.toList();
                  if (map[uid]['order'] != null) {
                    debugPrint(map[uid]['order'].toString());
                    final foodItemName =
                        map[uid]['order']['foodItemName'].toString();
                    final price = map[uid]['order']['foodPrice'].toString();
                    // print(dataList);
                    return Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                map[uid]['order']['foodImage'].toString(),
                                height: 100,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  foodItemName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "DMSans Bold",
                                  ),
                                ),
                                Text(
                                  "\$$price",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "DMSans Medium",
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(IconlyLight.buy),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }
              }),
        ],
      ),
    );
  }
}
