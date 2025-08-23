import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestionsWidget extends StatelessWidget {
  SuggestionsWidget({super.key, required this.label});
  final String label;
  final bool Quick = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          label.tr,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
          // textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
