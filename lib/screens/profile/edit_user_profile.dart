import 'package:flutter/material.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/services/database_services.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../widgets/custom_textformfield.dart';

class EditUserProfile extends StatefulWidget {
  final String userRole;
  const EditUserProfile({super.key, this.userRole = 'user'});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dateController;
  late TextEditingController cnincController;
  late TextEditingController addressController;
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
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateController.dispose();
    cnincController.dispose();
    addressController.dispose();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                          hint: Text(gender ?? "Gender"),
                          isExpanded: true,
                          underline:
                              const ColoredBox(color: Colors.transparent),
                          items: [
                            DropdownMenuItem(
                                value: "Male",
                                child: const Text("Male"),
                                onTap: () {
                                  setState(() {
                                    gender = "Male";
                                  });
                                }),
                            DropdownMenuItem(
                              value: "Female",
                              onTap: () {
                                setState(() {
                                  gender = "Female";
                                });
                              },
                              child: const Text("Female"),
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
                      hintText: 'Address',
                      label: 'Address',
                      icon: IconlyLight.location,
                      textEditingController: addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Address';
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
                      btnMargin: 0,
                      btnRadius: 15,
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            btnLoading = true;
                          });

                          // UserModel userModel = UserModel(
                          //   username: usernameController.text.toString(),
                          //   email: emailController.text.toString(),
                          //   dateofbith: dateController.text.toString(),
                          //   address: addressController.text.toString(),
                          //   gender: gender.toString(),
                          //   phone: phoneController.text.toString(),
                          //   cninc: cnincController.text.toString(),
                          //   userId: currentUser.toString(),
                          // );

                          DatabaseServices.saveUserCredentials(
                            username: usernameController.text.toString(),
                            email: emailController.text.toString(),
                            date: dateController.text.toString(),
                            role: widget.userRole.toString(),
                            address: addressController.text.toString(),
                            gender: gender.toString(),
                            phone: phoneController.text.toString(),
                            cnic: cnincController.text.toString(),
                          ).then((value) {
                            setState(() {
                              btnLoading = false;
                            });
                            Get.offAll(() => const LoginView());
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
