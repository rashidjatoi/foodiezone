import 'package:flutter/material.dart';
import 'package:foodiezone/services/auth_services.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';

class PasswordRecoveryView extends StatefulWidget {
  const PasswordRecoveryView({super.key});

  @override
  State<PasswordRecoveryView> createState() => _PasswordRecoveryViewState();
}

class _PasswordRecoveryViewState extends State<PasswordRecoveryView> {
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Password Recovery"),
        elevation: 0.8,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/forgetpassword.png",
                  height: 200,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your email address or phone number to recover your password",
                style: TextStyle(
                  fontFamily: "DMsans-Regular",
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: CustomTextFormField(
                  hintText: 'Email',
                  label: 'Email',
                  icon: Icons.email_outlined,
                  textEditingController: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                btnMargin: 0,
                btnText: "Send Link",
                ontap: () {
                  if (formKey.currentState!.validate()) {
                    AuthServices.sendResetLink(
                      emailController.text.toString(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
