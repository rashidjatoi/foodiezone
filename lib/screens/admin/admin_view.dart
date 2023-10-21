import 'package:flutter/material.dart';
import 'package:foodiezone/screens/admin/user/users_view.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/services/auth_services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'widgets/admin_view_btn.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Admin View"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              AdminViewButton(
                ontap: () {
                  Get.to(() => const UserView());
                },
                icon: IconlyBold.profile,
                iconText: "Users",
              ),
              AdminViewButton(
                ontap: () {},
                icon: IconlyBold.bookmark,
                iconText: "Bookings",
              ),
            ],
          ),
          Row(
            children: [
              AdminViewButton(
                ontap: () {},
                icon: IconlyBold.profile,
                iconText: "Users",
              ),
              AdminViewButton(
                ontap: () {
                  AuthServices.signOutUser()
                      .then((value) => Get.offAll(() => const LoginView()));
                },
                icon: IconlyBold.logout,
                iconColor: Colors.red,
                iconText: "Sign Out",
                textColor: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
