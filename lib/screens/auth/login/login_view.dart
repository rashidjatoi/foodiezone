import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/widgets.dart';
import 'package:foodiezone/screens/auth/password_recovery/password_recovery.dart';
import 'package:foodiezone/screens/auth/register/signup_view.dart';
import 'package:foodiezone/services/auth_services.dart';
import 'package:foodiezone/utils/utils.dart';
import 'package:get/get.dart';
import '../../../constants/images.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textform_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  bool btnLoading = false;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sizebox
            const SizedBox(height: 100),

            // App logo
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                appLogo1,
                height: 150,
              ),
            ),

            const SizedBox(height: 20),
            // App Slogan
            sloganWidget,

            const SizedBox(height: 50),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: 'email'.tr,
                    hintText: 'emailEnter'.tr,
                    textEditingController: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'passwordEnter'.tr,
                    labelText: 'pasword'.tr,
                    textEditingController: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                child: Text('forgertPassword'.tr),
                onPressed: () {
                  Get.to(() => const PasswordRecoveryView());
                },
              ),
            ),
            CustomButton(
              btnText: 'continue'.tr,
              loading: btnLoading,
              ontap: () {
                if (formKey.currentState!.validate()) {
                  try {
                    setState(() {
                      btnLoading = true;
                    });
                    AuthServices.signInUser(
                      emailController.text,
                      passwordController.text,
                    ).then(
                      (value) {
                        setState(() {
                          btnLoading = false;
                        });
                      },
                    );
                  } on FirebaseAuthException catch (e) {
                    Utils.showToast(
                      message: e.message.toString(),
                      bgColor: Colors.green,
                      textColor: Colors.white,
                    );
                    setState(() {
                      btnLoading = false;
                    });
                  }
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('dontHaveAccount'.tr),
                TextButton(
                  child: const Text("Sign up"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpView(),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
