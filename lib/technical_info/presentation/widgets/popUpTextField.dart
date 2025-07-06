import 'package:flutter/material.dart';

class Popuptextfield extends StatelessWidget {
  const Popuptextfield({super.key, required this.controller, required this.title, this.validator});

  final TextEditingController controller;
  final String title;
 final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
      validator: validator,
    );
  }
}
