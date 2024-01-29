import 'package:flutter/material.dart';
import 'package:foodiezone/constants/color_extension.dart';

class RoundIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  final Color color;
  final double size;
  final double fontSize;
  final FontWeight fontWeight;
  const RoundIconButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.size,
      required this.color,
      this.fontSize = 12,
      this.fontWeight = FontWeight.w500,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: size,
              color: Colors.white,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  color: TColor.white,
                  fontSize: fontSize,
                  fontWeight: fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}