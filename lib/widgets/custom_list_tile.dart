import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String tileText;
  final IconData tileIcon;
  final VoidCallback ontap;
  final Color iconColor;

  const CustomListTile({
    Key? key,
    required this.tileText,
    required this.tileIcon,
    required this.ontap,
    this.iconColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        tileIcon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.grey.shade700,
      ),
      onTap: ontap,
      title: Text(tileText),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black54,
      ),
    );
  }
}
