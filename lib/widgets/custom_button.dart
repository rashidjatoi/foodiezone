import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback ontap;
  final Color btnTextColor;
  final Color btnColor;
  final double btnRadius;
  final double btnHeight;
  final bool loading;

  final double btnMargin;
  final double btnWidth;
  const CustomButton({
    super.key,
    required this.btnText,
    required this.ontap,
    this.btnRadius = 8,
    this.loading = false,
    this.btnTextColor = Colors.white,
    this.btnColor = appcolor,
    this.btnWidth = double.infinity,
    this.btnHeight = 60,
    this.btnMargin = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth,
      height: btnHeight,
      margin: EdgeInsets.symmetric(horizontal: btnMargin),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : btnColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(btnRadius),
            ),
          ),
        ),
        onPressed: ontap,
        child: loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                btnText,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? appcolor
                      : btnTextColor,
                  fontFamily: "DMSans Medium",
                  // fontSize: 18,
                ),
              ),
      ),
    );
  }
}
