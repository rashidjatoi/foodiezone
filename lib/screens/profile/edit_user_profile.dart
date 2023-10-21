import 'package:flutter/material.dart';
import 'package:foodiezone/services/database_services.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../widgets/custom_textformfield.dart';

class EditUserProfile extends StatefulWidget {
  final String email;
  final String username;

  const EditUserProfile(
      {super.key, required this.email, required this.username});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dateController;
  late TextEditingController cnincController;
  final formKey = GlobalKey<FormState>();

  bool btnLoading = false;
  String? gender;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    dateController = TextEditingController();
    cnincController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateController.dispose();
    cnincController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text(
                "editProfileDetails",
                style: const TextStyle(
                  fontFamily: "DMsans-Regular",
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 15),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      textEditingController: usernameController,
                      hintText: 'Username',
                      label: 'Username',
                      icon: IconlyLight.profile,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: 'Email',
                      label: 'Email',
                      icon: IconlyLight.message,
                      textEditingController: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: 'Date (Format DD-MM-YY)',
                      label: 'DOB',
                      icon: Icons.date_range_outlined,
                      textEditingController: dateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
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
                          hint: const Text("Gender"),
                          isExpanded: true,
                          underline:
                              const ColoredBox(color: Colors.transparent),
                          items: const [
                            DropdownMenuItem(
                              value: "Male",
                              child: Text("Female"),
                            ),
                            DropdownMenuItem(
                              value: "Male",
                              child: Text("Male"),
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: 'Phone Number',
                      label: 'Phone Number',
                      icon: IconlyLight.call,
                      textEditingController: phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Phone Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: 'CNIC',
                      label: 'CNIC',
                      icon: Icons.credit_card,
                      textEditingController: cnincController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your CNIC';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      btnText: "Save Profile",
                      loading: btnLoading,
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            btnLoading = true;
                          });
                          String email = widget.email;
                          usernameController.text = widget.username.toString();
                          DatabaseServices.saveUserCredentials(
                            email: email,
                            username: usernameController.text.toString(),
                            date: dateController.text.toString(),
                            gender: gender.toString(),
                            cnic: cnincController.text.toString(),
                            phone: phoneController.text.toString(),
                          ).then((value) {
                            setState(() {
                              btnLoading = false;
                            });
                            Get.back();
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
