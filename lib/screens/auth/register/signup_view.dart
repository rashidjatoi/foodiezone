import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/images.dart';
import 'package:foodiezone/services/auth_services.dart';
import 'package:foodiezone/utils/utils.dart';
import 'package:get/get.dart';
import '../../../constants/widgets.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textform_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool btnLoading = false;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Form Key
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sizebox
              const SizedBox(height: 50),

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

              // Sizebox
              const SizedBox(height: 50),

              // Form
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // first name textfield
                      CustomTextFormField(
                        labelText: "First Name",
                        hintText: "First Name",
                        textEditingController: firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter First Name';
                          }
                          return null;
                        },
                      ),

                      // Sizebox
                      const SizedBox(height: 10),

                      // Last Name textfield
                      CustomTextFormField(
                        labelText: "Last Name",
                        hintText: "Last Name",
                        textEditingController: lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Last Name';
                          }
                          return null;
                        },
                      ),

                      // Email
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: "Email",
                        hintText: "Enter your Email",
                        textEditingController: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                      ),

                      // Password
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: "Password",
                        hintText: "Enter your Password",
                        textEditingController: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),

              // Forget Password
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: const Text("Forget Password"),
                  onPressed: () {},
                ),
              ),

              // Continue Button
              CustomButton(
                btnText: "Continue",
                loading: btnLoading,
                ontap: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      setState(() {
                        btnLoading = true;
                      });

                      AuthServices.createUser(
                        emailController.text,
                        passwordController.text,
                      ).then((value) async {
                        setState(() {
                          btnLoading = false;
                        });
                        // Get.off(() => EditUserProfile(
                        //       email: emailController.text.toString(),
                        //       username: usernameController.text.toString(),
                        //     ));

                        Get.back();
                      });
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

              // Don't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account"),
                  TextButton(
                    child: const Text("Sign in"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
