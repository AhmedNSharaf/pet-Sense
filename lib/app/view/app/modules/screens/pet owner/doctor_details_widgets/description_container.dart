import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../model/doctor_model.dart';

class DescriptionContainer extends StatelessWidget {
  final Doctor doctor;
  const DescriptionContainer({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Color(0xff01727A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  doctor.image,
                  height: 118,
                  width: 121,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: GoogleFonts.cairo(
                          fontSize: 20,
                          color: Color(0xffFDFDFD),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      doctor.specialty,
                      style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Color(0xffECECEC),
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 14),
                    Divider(
                      color: Color(0xffA0A0A0),
                      thickness: 1,
                    ),
                    SizedBox(height: 8),
                    Text(
                      doctor.address,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                          fontSize: 15,
                          color: Color(0xffFDFDFD),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
