import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElvatedButton extends StatelessWidget {
  Function()? onTap;
  bool needArrow;
  bool needCart;
  final String text;
  CustomElvatedButton({
    super.key,
    this.onTap,
    this.needArrow = true,
    this.needCart = false, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff01727A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text.tr,
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xffFDFDFD),
            ),
          ),
          const SizedBox(width: 4),
          needArrow
              ? const Icon(Icons.arrow_forward_ios, color: Color(0xffFDFDFD))
              : needCart
              ? const Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xffFDFDFD),
                )
              : Container(),
        ],
      ),
    );
  }
}
