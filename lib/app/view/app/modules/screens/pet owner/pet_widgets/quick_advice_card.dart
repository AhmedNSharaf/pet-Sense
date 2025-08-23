import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../model/quick_advice_model.dart';

class QuickAdviceCard extends StatelessWidget {
  final QuickAdviceModel advice;

  const QuickAdviceCard({super.key, required this.advice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
        child: Row(
          children: [
            Icon(advice.icon, color: const Color(0XFF029CA7), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                advice.message.tr,
                style: GoogleFonts.cairo(
                  color: const Color(0XFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
