import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/screens/profile/edit_user_profile.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../rider/rider_account/rider_account.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  int selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Type'),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Please Select any one of these to Continue",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: "DMSans Medium",
              // fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          CustomButtonForAccountType(
            imgPath: "assets/images/images/couple.png",
            buttonText: 'Continue as a User',
            isSelected: selectedButtonIndex == 1,
            onPressed: () {
              setState(() {
                selectedButtonIndex = 1;
              });

              Get.offAll(() => const EditUserProfile());
            },
          ),
          const SizedBox(height: 20),
          CustomButtonForAccountType(
            imgPath: "assets/images/images/rider.png",
            buttonText: 'Continue as a Rider',
            isSelected: selectedButtonIndex == 0,
            onPressed: () {
              setState(() {
                selectedButtonIndex = 0;
              });

              Get.offAll(() => const RiderAccountDetailsScreen());
            },
          ),
          const SizedBox(height: 20),
          CustomButtonForAccountType(
            imgPath: "assets/images/images/chef.png",
            buttonText: 'Continue as a Chef',
            isSelected: selectedButtonIndex == 2,
            onPressed: () {
              setState(() {
                selectedButtonIndex = 2;
              });

              Get.offAll(() => const EditUserProfile());
            },
          ),
        ],
      ),
    );
  }
}

class CustomButtonForAccountType extends StatelessWidget {
  final String buttonText;
  final bool isSelected;
  final String imgPath;
  final VoidCallback onPressed;

  const CustomButtonForAccountType({
    Key? key,
    required this.buttonText,
    required this.isSelected,
    required this.imgPath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? appcolor : Colors.grey),
          borderRadius: BorderRadius.circular(25),
          color: isSelected ? appcolor : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imgPath,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    buttonText,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontFamily: "DMSans Medium"),
                  ),
                ],
              ),
              Icon(
                IconlyLight.arrow_right,
                color: isSelected ? Colors.white : Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
