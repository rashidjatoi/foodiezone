import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../services/database_services.dart';
import '../../../widgets/custom_textformfield.dart';

class AdminHelpDeskScreen extends StatefulWidget {
  final String email;
  final String userUid;
  const AdminHelpDeskScreen({
    Key? key,
    required this.email,
    required this.userUid,
  }) : super(key: key);

  @override
  State<AdminHelpDeskScreen> createState() => _AdminHelpDeskScreenState();
}

class _AdminHelpDeskScreenState extends State<AdminHelpDeskScreen> {
  final TextEditingController message = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Desk"),
      ),
      body: Column(
        children: [
          // List Messages
          Expanded(
            child: FirebaseAnimatedList(
              query: FirebaseDatabase.instance
                  .ref('helpdesk')
                  .child(widget.userUid.toString())
                  .orderByChild('Timestamp'),
              itemBuilder: (context, snapshot, animation, index) {
                final email = snapshot.child('UserEmail').value;
                final mesg = snapshot.child('Message').value;
                final isAdminMessage = snapshot.child('IsAdminMessage').value;

                if (isAdminMessage == true) {
                  return ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.admin_panel_settings_sharp,
                          color: Colors.white,
                        )),
                    title: Text(mesg.toString()),
                    subtitle: const Text("Help Desk"),
                  );
                } else {
                  return ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                    title: Text(mesg.toString()),
                    subtitle: Text(email.toString()),
                  );
                }
              },
            ),
          ),

          // Post Messages
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: CustomTextFormField(
                      hintText: "fieldText",
                      label: "",
                      icon: IconlyLight.message,
                      textEditingController: message,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter message';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      DatabaseServices.postAdminMessages(
                        message: message.text.toString(),
                        recipientEmail: widget.email.toString(),
                        uid: widget.userUid.toString(),
                      ).then(
                        (value) => message.clear(),
                      );
                    }
                  },
                  icon: const Icon(IconlyLight.send),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
