import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'helpdesk/admin_help_desk_view.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({super.key});

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  final users = FirebaseDatabase.instance.ref('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              child: FirebaseAnimatedList(
                query: users.orderByChild('Timestamp'),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.value != null) {
                    final imageUrl = snapshot.child('imageUrl').value;
                    final name = snapshot.child('username').value;
                    final email = snapshot.child('email').value;
                    final uid = snapshot.child('userId').value;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminHelpDeskScreen(
                                email: email.toString(),
                                userUid: uid.toString(),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: CircleAvatar(
                                radius: 20,
                                child: SizedBox(
                                  height: 140,
                                  width: 120,
                                  child: Image.network(
                                    imageUrl.toString(),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Name: ",
                                      style: TextStyle(
                                        fontFamily: "DMSans Bold",
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      name.toString(),
                                      style: const TextStyle(
                                        fontFamily: "DMSans Medium",
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Email: ",
                                      style: TextStyle(
                                        fontFamily: "DMSans Bold",
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      email.toString(),
                                      style: const TextStyle(
                                        fontFamily: "DMSans Medium",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.black,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
