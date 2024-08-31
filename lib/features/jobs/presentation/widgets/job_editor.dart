import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JobEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final int? maxLength;
  const JobEditor(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: [
          // Allow letters, spaces, and specified special characters
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s\-_.@()/&]')),
        ],
        validator: (value) {
          // Trim the input value to remove leading and trailing spaces
          String trimmedValue = value!.trim();

          if (trimmedValue.isEmpty) {
            return '$hintText is missing';
          }
          // if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
          //   return '$hintText contains unusual characters';
          // }
          return null;
        });
  }
}
