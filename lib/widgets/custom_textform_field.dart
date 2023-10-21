import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final int maxLength;
  final String? Function(String?)? validator;

  final TextEditingController textEditingController;
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.textEditingController,
    required this.hintText,
    required this.validator,
    this.maxLength = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: textEditingController,
        maxLines: maxLength,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
