import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
// import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/services/database_services.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/custom_textformfield.dart';

class FoodProviderDetailsView extends StatefulWidget {
  const FoodProviderDetailsView({super.key});

  @override
  State<FoodProviderDetailsView> createState() =>
      _FoodProviderDetailsViewState();
}

class _FoodProviderDetailsViewState extends State<FoodProviderDetailsView> {
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

  File? image;
  final picker = ImagePicker();

  Future getImageGalley() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    setState(
      () {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          debugPrint("No image picked");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Food Provider Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: getImageGalley,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: image != null
                        ? Image.file(
                            image!.absolute,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )
                        : Icon(
                            IconlyBold.image,
                            size: 50,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? customThemeColor
                                    : Colors.black,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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

                          if (image != null) {
                            final newId = DateTime.now().millisecondsSinceEpoch;

                            firebase_storage.Reference ref = firebase_storage
                                .FirebaseStorage.instance
                                .ref("/users/$newId");

                            firebase_storage.UploadTask uploadTask =
                                ref.putFile(image!.absolute);

                            Future.value(uploadTask).then((value) async {
                              var imageUrl = await ref.getDownloadURL();

                              DatabaseServices.saveFoodProviderDetails(
                                username: usernameController.text.toString(),
                                newUrl: imageUrl,
                                email: emailController.text.toString(),
                                address: addressController.text.toString(),
                                phone: phoneController.text.toString(),
                              ).then((value) {
                                setState(() {
                                  btnLoading = false;
                                });
                                Get.back();
                              });
                            });
                          }
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
