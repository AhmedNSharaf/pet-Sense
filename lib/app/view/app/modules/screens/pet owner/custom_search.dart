import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearch extends StatelessWidget {
  bool needFilter ;
  CustomSearch({super.key, this.needFilter = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
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
        child: TextField(
          cursorColor: Color(0xff01727A),
          decoration: InputDecoration(
            hintText: 'search_doctor_store_service'.tr,
            hintStyle: GoogleFonts.cairo(
              color: Colors.grey,
              fontSize: 14,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xff01727A),
            ),
             suffixIcon: needFilter ? const Icon(
              Icons.filter_list_outlined,
              color: Color(0xff01727A),
            ):null
          ),
        ),
      ),
    );
  }
}
