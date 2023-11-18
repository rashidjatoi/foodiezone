import 'package:flutter/material.dart';
import 'package:foodiezone/services/database_services.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../widgets/custom_textformfield.dart';

class FoodDriverAccountDetailsView extends StatefulWidget {
  const FoodDriverAccountDetailsView({super.key});

  @override
  State<FoodDriverAccountDetailsView> createState() =>
      _FoodDriverAccountDetailsViewState();
}

class _FoodDriverAccountDetailsViewState
    extends State<FoodDriverAccountDetailsView> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
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
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Food Driver Account"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Image.asset(
                "assets/images/images/rider.png",
                height: 200,
              ),
              const SizedBox(height: 15),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      textEditingController: usernameController,
                      hintText: 'Company',
                      label: 'Company',
                      icon: IconlyLight.profile,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter company name';
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
                    CustomButton(
                      btnText: "Save Profile",
                      loading: btnLoading,
                      btnMargin: 0,
                      btnRadius: 12,
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            btnLoading = true;
                          });

                          DatabaseServices.saveFoodDriverDetails(
                            username: usernameController.text.toString(),
                            email: emailController.text.toString(),
                            address: addressController.text.toString(),
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
