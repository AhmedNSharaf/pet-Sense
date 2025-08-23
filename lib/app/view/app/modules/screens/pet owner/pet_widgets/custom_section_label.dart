
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSectionLabel extends StatelessWidget {
  const CustomSectionLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        label.tr,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.cairo().fontFamily,
        ),
      ),
    );
  }
}
