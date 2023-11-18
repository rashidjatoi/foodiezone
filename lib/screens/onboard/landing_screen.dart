import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/screens/auth/login/login_view.dart';
import 'package:foodiezone/screens/auth/register/signup_view.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:shadow_clip/shadow_clip.dart';
import '../../utils/helper.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = "/landingScreen";

  const LandingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipShadow(
              clipper: CustomClipperAppBar(),
              boxShadow: const [
                BoxShadow(
                  color: AppColor.placeholder,
                  offset: Offset(0, 15),
                  blurRadius: 10,
                ),
              ],
              child: Container(
                width: double.infinity,
                height: Helper.getScreenHeight(context) * 0.5,
                decoration: ShapeDecoration(
                  color: appcolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Image.asset(
                  Helper.getAssetName("login_bg.png", "virtual"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/icons/logo.png",
              height: 150,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: Helper.getScreenHeight(context) * 0.3,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Flexible(
                    child: Text(
                      'slogan'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "DMSans Medium",
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    btnText: 'signin'.tr,
                    btnMargin: 0,
                    btnRadius: 50,
                    ontap: () {
                      Get.to(() => const LoginView());
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(appcolor),
                        shape: MaterialStateProperty.all(
                          const StadiumBorder(
                            side: BorderSide(color: appcolor, width: 1.5),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => const SignUpView());
                      },
                      child: Text('createaccount'.tr),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class CustomClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width * 0.24, size.height);
    Offset endPoint = Offset(size.width * 0.25, size.height * 0.96);
    Offset controlPoint2 = Offset(size.width * 0.3, size.height * 0.78);
    Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.78);
    Offset controlPoint3 = Offset(size.width * 0.7, size.height * 0.78);
    Offset endPoint3 = Offset(size.width * 0.75, size.height * 0.96);
    Offset controlPoint4 = Offset(size.width * 0.76, size.height);
    Offset endPoint4 = Offset(size.width * 0.79, size.height);
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.21, size.height)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint2.dx,
        endPoint2.dy,
      )
      ..quadraticBezierTo(
        controlPoint3.dx,
        controlPoint3.dy,
        endPoint3.dx,
        endPoint3.dy,
      )
      ..quadraticBezierTo(
        controlPoint4.dx,
        controlPoint4.dy,
        endPoint4.dx,
        endPoint4.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
