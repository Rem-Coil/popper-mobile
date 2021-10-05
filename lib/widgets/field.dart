import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isHidden;
  final IconData icon;
  final bool isNumberField;
  final FormFieldValidator<String> validator;

  const Field({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.validator,
    this.isHidden = false,
    this.isNumberField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: isHidden,
      controller: controller,
      keyboardType: isNumberField ? TextInputType.number : null,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
