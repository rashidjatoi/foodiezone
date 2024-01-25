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
        title: const Text("Orders"),
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

                    // print(map);
                    List<dynamic> list = [];
                    list.clear();
                    list = map.values.toList();
                    if (map[uid]['order'] != null) {
                      // debugPrint(map[uid]['order'].toString());
                      // final foodItemName =
                      //     map[uid]['order']['foodItemName'].toString();
                      // final price = map[uid]['order']['foodPrice'].toString();
                      // final userId = map[uid]['order']['userId'].toString();

                      final data = snapshot.data!.snapshot.value
                          as Map<dynamic, dynamic>;

                      // print(map[uid]['order']);
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
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: foodImage,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  title: Text(foodItemName),
                                  subtitle: Text(foodDesc),
                                  trailing: Text(
                                    "\$ $price",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return const ListTile();
                    }

                    return const Text("data");
                  }
                }),
          ),
        ],
      ),
    );
  }
}
