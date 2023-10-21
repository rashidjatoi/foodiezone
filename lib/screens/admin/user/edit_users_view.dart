import 'package:flutter/material.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:foodiezone/utils/utils.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';

import 'widgets/custom_table_widget.dart';

class EditUsersView extends StatefulWidget {
  final Map<String, dynamic> data;
  const EditUsersView({super.key, required this.data});

  @override
  State<EditUsersView> createState() => _EditUsersViewState();
}

class _EditUsersViewState extends State<EditUsersView> {
  String role = "";
  bool btnLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Users Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
              ),
              children: [
                customTableWidget(
                  headingText: "Name",
                  dataText: widget.data["username"],
                ),
                customTableWidget(
                  headingText: "Email",
                  dataText: widget.data["email"],
                ),
                customTableWidget(
                  headingText: "Phone",
                  dataText: widget.data["phone"],
                ),
                customTableWidget(
                  headingText: "CNIC",
                  dataText: widget.data["cnic"],
                ),
                customTableWidget(
                  headingText: "Date of Birth",
                  dataText: widget.data["date"],
                ),
                customTableWidget(
                  headingText: "Gender",
                  dataText: widget.data["gender"],
                ),
                TableRow(
                  children: [
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Role"),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["role"]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: DropdownButton(
                  value: role.isNotEmpty ? role : null,
                  hint: const Text("Role"),
                  isExpanded: true,
                  underline: const ColoredBox(color: Colors.transparent),
                  items: const [
                    DropdownMenuItem(
                      value: "user",
                      child: Text("user"),
                    ),
                    DropdownMenuItem(
                      value: "hosteler",
                      child: Text("hosteler"),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      role = value.toString();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              btnText: "Update",
              loading: btnLoading,
              ontap: () {
                try {
                  setState(() {
                    btnLoading = true;
                  });
                  hostelDatabase.child(widget.data["uid"]).update(
                    {
                      "role": role,
                    },
                  ).then((value) {
                    setState(() {
                      btnLoading = false;
                    });
                    Get.back();
                    Utils.showToast(
                      message: "Role Changed",
                      bgColor: Colors.green,
                      textColor: Colors.white,
                    );
                  });
                } catch (e) {
                  debugPrint(e.toString());
                  setState(() {
                    btnLoading = false;
                  });
                }
                debugPrint(widget.data["uid"]);
              },
            )
          ],
        ),
      ),
    );
  }
}
