import 'package:flutter/material.dart';

class AdminViewButton extends StatelessWidget {
  final IconData icon;
  final String iconText;
  final VoidCallback ontap;
  final Color iconColor;
  final Color textColor;

  const AdminViewButton({
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

    // Define colors for light mode and dark mode
    const Color lightIconColor = Colors.black;
    const Color lightTextColor = Colors.black;
    const Color darkIconColor = Colors.white; // Change to your preferred color
    const Color darkTextColor = Colors.white; // Change to your preferred color

    // Determine the appropriate colors based on the current theme mode
    final Color finalIconColor =
        currentBrightness == Brightness.dark ? darkIconColor : lightIconColor;
    final Color finalTextColor =
        currentBrightness == Brightness.dark ? darkTextColor : lightTextColor;

    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 100,
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
                color: finalIconColor, // Use the final icon color
              ),
              Text(
                iconText,
                style: TextStyle(
                  color: finalTextColor, // Use the final text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
