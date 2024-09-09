import 'package:flutter/material.dart';

class FirstOpenWidgets extends StatelessWidget {
  final String tittle;
  final String imgPath;
  final double? height;
  const FirstOpenWidgets({
    super.key,
    required this.tittle,
    required this.imgPath,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(tittle,
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: height,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(imgPath),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
