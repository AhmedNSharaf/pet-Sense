import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_sense/app/view/app/modules/screens/pet%20owner/doctor_details_widgets/description_container.dart';
import 'package:pet_sense/app/view/app/modules/screens/pet%20owner/doctor_details_widgets/doctor_reviews.dart';
import 'package:pet_sense/app/view/app/modules/screens/pet%20owner/doctor_details_widgets/doctor_working_time.dart';
import '../../../../../model/doctor_model.dart';
import 'custom_app_bar.dart';
import 'custom_elvated_button.dart';
import 'doctor_details_widgets/about_doctor.dart';
import 'doctor_details_widgets/list_doctor_data.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;
  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: doctor.name, isHeart: true),
              DescriptionContainer(doctor: doctor),
              SizedBox(height: 72, child: ListDoctorData(doctor: doctor)),
              SizedBox(height: 24),
              AboutDoctor(doctor: doctor),
              SizedBox(height: 16),
              DoctorWorkingTime(doctor: doctor),
              SizedBox(height: 24),
              DoctorReviews(comments: doctor.Comments),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16 ),
                child: CustomElvatedButton(text: 'Book Appointment',needArrow: false, onTap: (){},),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
