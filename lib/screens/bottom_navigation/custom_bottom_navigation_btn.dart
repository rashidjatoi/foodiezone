import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';

class CustomBottomNavigationButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;
  final IconData selectedIcon;
  final IconData icon;

  const CustomBottomNavigationButton({
    super.key,
    required this.selectedIcon,
    required this.icon,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      selectedIcon: Icon(
        selectedIcon,
        size: 30,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : customThemeColor,
      ),
      isSelected: isSelected,
      icon: Icon(
        isSelected ? selectedIcon : icon,
        size: 30,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : customThemeColor,
      ),
    );
  }
}
