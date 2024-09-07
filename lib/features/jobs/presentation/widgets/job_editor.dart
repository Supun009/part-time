import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
        style: GoogleFonts.notoSansSinhala(),
        controller: controller,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: [
          // Allow letters, spaces, numbers, and emojis
          FilteringTextInputFormatter.allow(RegExp(r'.*')),
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
