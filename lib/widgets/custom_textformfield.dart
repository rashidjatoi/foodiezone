import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool canEdit;
  final String? Function(String?)? validator;
  final String label;
  final TextEditingController textEditingController;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.validator,
    this.label = '',
    this.canEdit = true,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      enabled: canEdit,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 0.8),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
