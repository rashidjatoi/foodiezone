import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/services/services_constants.dart';

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
        title: const Text("My Orders"),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
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

                    List<dynamic> list = [];
                    list.clear();
                    list = map.values.toList();
                    if (map[uid]['order'] != null) {
                      final data = snapshot.data!.snapshot.value
                          as Map<dynamic, dynamic>;

                      if (data.containsKey(uid) && data[uid]['order'] != null) {
                        final orderMap =
                            data[uid]['order'] as Map<dynamic, dynamic>;

                        return ListView.builder(
                          itemCount: orderMap.length,
                          itemBuilder: (BuildContext context, int index) {
                            final orderKey = orderMap.keys.elementAt(index);
                            final orderDetails =
                                orderMap[orderKey] as Map<dynamic, dynamic>;

                            final foodItemName =
                                orderDetails['foodItemName'].toString();
                            final price = orderDetails['foodPrice'].toString();
                            final foodImage =
                                orderDetails['foodImage'].toString();

                            final foodDesc =
                                orderDetails['foodDescription'].toString();

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () {},
                                    leading: CircleAvatar(
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: foodImage,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    title: Text(foodItemName),
                                    subtitle: Text(
                                      foodDesc,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: Text(
                                      "Rs $price",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(
                        child: Text(
                          "No Orders Available",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "DMSans Medium",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }

                    return const Text("");
                  }
                }),
          ),
        ],
      ),
    );
  }
}
