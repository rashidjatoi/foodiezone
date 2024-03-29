import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodProviderViewButton extends StatelessWidget {
  final IconData icon;
  final String iconText;
  final VoidCallback ontap;
  final Color iconColor;
  final Color textColor;

  const FoodProviderViewButton({
    Key? key,
    required this.icon,
    required this.iconText,
    required this.ontap,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current brightness mode (light or dark) from the theme
    final Brightness currentBrightness = Theme.of(context).brightness;

    const Color lightTextColor = Colors.black;
    const Color darkTextColor = Colors.white;

    final Color finalTextColor =
        currentBrightness == Brightness.dark ? darkTextColor : lightTextColor;

    return Expanded(
      child: CupertinoButton(
        onPressed: ontap,
        padding: const EdgeInsets.all(0),
        child: Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: iconColor,
              ),
              const SizedBox(height: 15),
              Text(
                iconText,
                style: TextStyle(
                  color: finalTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
