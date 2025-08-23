import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../model/doctor_model.dart';

class AboutDoctor extends StatelessWidget {
  final Doctor doctor;
  const AboutDoctor({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Doctor ${doctor.name}',
            style: GoogleFonts.cairo(
              color: Color(0xff333333),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            doctor.about,
            style: GoogleFonts.cairo(
              color: Color(0xffA0A0A0),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
