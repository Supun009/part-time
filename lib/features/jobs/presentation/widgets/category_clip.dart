import 'package:flutter/material.dart';
import 'package:parttime/core/theme/app_pallete.dart';

class CategoryClip extends StatelessWidget {
  final String categoryName;
  final void Function()? onTap;
  final bool isCategoryValid;
  final WidgetStateProperty<Color?>? color;
  const CategoryClip({
    super.key,
    required this.categoryName,
    required this.onTap,
    required this.color,
    required this.isCategoryValid,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Chip(
              label: Text(categoryName),
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              side: isCategoryValid
                  ? BorderSide.none
                  : BorderSide(
                      color: AppPallete.errorColor,
                    ),
            )));
  }
}
