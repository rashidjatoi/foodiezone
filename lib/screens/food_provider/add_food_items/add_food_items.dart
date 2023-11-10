import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:foodiezone/utils/utils.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:foodiezone/widgets/custom_textformfield.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodItemsView extends StatefulWidget {
  const AddFoodItemsView({super.key});

  @override
  State<AddFoodItemsView> createState() => _AddFoodItemsViewState();
}

class _AddFoodItemsViewState extends State<AddFoodItemsView> {
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

  late TextEditingController nameC;
  late TextEditingController price;
  late TextEditingController description;

  @override
  void initState() {
    super.initState();
    description = TextEditingController();
    nameC = TextEditingController();
    price = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    description.dispose();
    nameC.dispose();
    price.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                StreamBuilder(
                    stream: firebaseDatabase.onValue,
                    builder: (BuildContext context,
                        AsyncSnapshot<DatabaseEvent> snapshot) {
                      final user = firebaseAuth.currentUser;
                      final uid = user?.uid;

                      if (!snapshot.hasData) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ],
                          ),
                        );
                      } else {
                        Map<dynamic, dynamic> map =
                            snapshot.data!.snapshot.value as dynamic;

                        // print(map);
                        List<dynamic> list = [];
                        list.clear();
                        list = map.values.toList();

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
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
                                      hintText: "Food Item Name",
                                      icon: IconlyLight.profile,
                                      textEditingController: nameC,
                                      label: "Name",
                                    ),
                                    const SizedBox(height: 15),
                                    CustomTextFormField(
                                      hintText: "Description",
                                      icon: IconlyLight.info_square,
                                      textEditingController: description,
                                      label: "Description",
                                    ),
                                    const SizedBox(height: 15),
                                    CustomTextFormField(
                                      hintText: "Price",
                                      icon: IconlyLight.info_square,
                                      label: "Price",
                                      textEditingController: price,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              CustomButton(
                                btnText: "Add Product",
                                loading: btnLoading,
                                btnMargin: 0,
                                ontap: () {
                                  try {
                                    setState(() {
                                      btnLoading = true;
                                    });

                                    if (image != null) {
                                      final newId =
                                          DateTime.now().millisecondsSinceEpoch;

                                      firebase_storage.Reference ref =
                                          firebase_storage
                                              .FirebaseStorage.instance
                                              .ref("/food/$newId");

                                      firebase_storage.UploadTask uploadTask =
                                          ref.putFile(image!.absolute);

                                      Future.value(uploadTask)
                                          .then((value) async {
                                        var newUrl = await ref.getDownloadURL();

                                        foodProviderDatabase
                                            .child(map[uid]['userId'])
                                            .child('food')
                                            .set(
                                          {
                                            'imageUrl': newUrl,
                                            'fooditemname':
                                                nameC.text.toString(),
                                            'description':
                                                description.text.toString(),
                                            'price': price.text.toString(),
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
                                      // await hostelDatabase
                                      //     .child(widget.userData['uid'])
                                      //     .update(
                                      //   {
                                      //     'username': nameC.text.toString(),
                                      //     'phone': phoneC.text.toString(),
                                      //     'date': dobC.text.toString(),
                                      //     'address': addressC.text.toString(),
                                      //     'cninc': cnicC.text.toString(),
                                      //     'gender': genderC.text.toString(),
                                      //   },
                                      // ).then(
                                      //   (value) {
                                      //     Utils.showToast(
                                      //       message: 'Changes Saved',
                                      //       bgColor: Colors.green,
                                      //       textColor: Colors.white,
                                      //     );

                                      //     setState(() {
                                      //       btnLoading = false;
                                      //     });
                                      //   },
                                      // );
                                    }
                                  } catch (e) {
                                    setState(() {
                                      btnLoading = false;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        );
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
