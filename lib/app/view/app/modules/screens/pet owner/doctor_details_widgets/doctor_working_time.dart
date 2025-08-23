import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../model/doctor_model.dart';
import '../pet_widgets/suggestions_widget.dart';

class DoctorWorkingTime extends StatelessWidget {
  final Doctor doctor;
  const DoctorWorkingTime({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Working Hours',
            style: GoogleFonts.cairo(
              color: Color(0xff333333),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SuggestionsWidget(label: doctor.workingHours,)
      ],
    );
  }
}
