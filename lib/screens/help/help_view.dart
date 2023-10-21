import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../services/database_services.dart';
import '../../services/services_constants.dart';
import '../../widgets/custom_textformfield.dart';

class HelpDeskView extends StatefulWidget {
  const HelpDeskView({super.key});

  @override
  State<HelpDeskView> createState() => _HelpDeskViewState();
}

class _HelpDeskViewState extends State<HelpDeskView> {
  final TextEditingController message = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final uid = firebaseAuth.currentUser!.uid;

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
                  .child(uid.toString())
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
                      hintText: "Say Hi!",
                      // label: "Say Hi!",

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
                      DatabaseServices.postMessages(
                              message: message.text.toString())
                          .then((value) => message.clear());
                    }
                  },
                  icon: const Icon(Icons.arrow_circle_up),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
