import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/utils/utils.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:foodiezone/widgets/custom_textformfield.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/services_constants.dart';

class ProfileDetailsView extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ProfileDetailsView({super.key, required this.userData});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> {
  // Form Key
  final formKey = GlobalKey<FormState>();
  File? image;
  final picker = ImagePicker();

  bool btnLoading = false;

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

  late TextEditingController emailC;
  late TextEditingController nameC;
  late TextEditingController phoneC;
  late TextEditingController addressC;
  late TextEditingController dobC;
  late TextEditingController cnicC;
  late TextEditingController genderC;

  @override
  void initState() {
    super.initState();
    emailC = TextEditingController(text: widget.userData['email']);
    nameC = TextEditingController(text: widget.userData['username']);
    phoneC = TextEditingController(text: widget.userData['phone']);
    addressC = TextEditingController(text: widget.userData['address']);
    dobC = TextEditingController(text: widget.userData['date']);
    cnicC = TextEditingController(text: widget.userData['cnic']);
    genderC = TextEditingController(text: widget.userData['gender']);
  }

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    nameC.dispose();
    phoneC.dispose();
    addressC.dispose();
    dobC.dispose();
    genderC.dispose();
    cnicC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal information"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
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
                      hintText: "Name",
                      icon: IconlyLight.profile,
                      textEditingController: nameC,
                      label: "Name",
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: "Email",
                      icon: Icons.email_outlined,
                      label: "Email",
                      textEditingController: emailC,
                      canEdit: false,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: "Phone",
                      icon: Icons.phone,
                      textEditingController: phoneC,
                      label: "Phone",
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: "Address",
                      icon: IconlyLight.location,
                      textEditingController: addressC,
                      label: "Address",
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: "CNIC",
                      icon: IconlyLight.info_square,
                      label: "CNIC",
                      textEditingController: cnicC,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: "Date of Birth",
                      icon: IconlyLight.calendar,
                      label: "Date of Birth",
                      textEditingController: dobC,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      hintText: "Gender",
                      icon: Icons.people_outline,
                      label: "Gender",
                      textEditingController: genderC,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              CustomButton(
                  btnText: "Update Profile",
                  loading: btnLoading,
                  btnMargin: 0,
                  ontap: () async {
                    try {
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
                          var newUrl = await ref.getDownloadURL();

                          firebaseDatabase.child(widget.userData['uid']).update(
                            {
                              'imageUrl': newUrl,
                              'username': nameC.text.toString(),
                              'phone': phoneC.text.toString(),
                              'date': dobC.text.toString(),
                              'address': addressC.text.toString(),
                              'cninc': cnicC.text.toString(),
                              'gender': genderC.text.toString(),
                            },
                          ).then((value) {
                            Utils.showToast(
                              message: 'Changes Saved',
                              bgColor: Colors.green,
                              textColor: Colors.white,
                            );
                            setState(() {
                              btnLoading = false;
                            });
                          });
                        });
                      } else {
                        await hostelDatabase
                            .child(widget.userData['uid'])
                            .update(
                          {
                            'username': nameC.text.toString(),
                            'phone': phoneC.text.toString(),
                            'date': dobC.text.toString(),
                            'address': addressC.text.toString(),
                            'cninc': cnicC.text.toString(),
                            'gender': genderC.text.toString(),
                          },
                        ).then(
                          (value) {
                            Utils.showToast(
                              message: 'Changes Saved',
                              bgColor: Colors.green,
                              textColor: Colors.white,
                            );

                            setState(() {
                              btnLoading = false;
                            });
                          },
                        );
                      }
                    } catch (e) {
                      setState(() {
                        btnLoading = false;
                      });
                    }
                  }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
