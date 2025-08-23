import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_sense/app/model/doctor_model.dart';

class ListDoctorData extends StatelessWidget {
  final Doctor doctor;
  const ListDoctorData({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> getDoctorData = {
      'Patients': doctor.numberOfPatients,
      'Experience': doctor.experience,
      'Rating': doctor.rating,
      'Comments': doctor.noOfReviews,
    };

    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: getDoctorData.length, // ✅ هنا الطول مظبوط
      itemBuilder: (context, index) {
        final value = getDoctorData.values.elementAt(index);
        final key = getDoctorData.keys.elementAt(index);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 8),
          child: Container(
            width: 80,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xffFDFDFD),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.toString(),
                  style: GoogleFonts.cairo(
                    color: const Color(0xff333333),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  key,
                  style: GoogleFonts.cairo(
                    color: const Color(0xff333333),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
