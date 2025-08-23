import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_sense/app/model/comment_model.dart';
import '../../../../../../model/doctor_model.dart';
import '../doctor_details_screen.dart';
import '../pet_widgets/dotor_card_item.dart';

class DoctorsList extends StatelessWidget {
  DoctorsList({super.key});
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Ahmed Ali',
      specialty: 'Skin and hair diseases',
      image: 'assets/doctor.jpg',
      rating: 4.5,
      price: '100 pounds / examination',
      distance: '30 minutes away from you',
      status: 'Online',
      address: '123 Main Street, New York, NY 10001',
      experience: 8,
      numberOfPatients: 600,
      about: 'Specialist in skin and hair with over 8 years of experience.',
      noOfReviews: 105,
      workingHours: '9:00 AM - 5:00 PM',
      Comments: [
        CommentModel(
          image: 'assets/doctor.jpg',
          name: 'Mohamed Ali',
          comment:
          'I had a great experience with Dr. Ahmed Ali. He was very knowledgeable and patient.',
          numberOfLikes: 65,
          time: 'before 6 days',
        ),
        CommentModel(
          image: 'assets/doctor2.jpg',
          name: 'Enas Ibrahim',
          comment:
          'Professional and kind doctor. Helped me a lot with my skin issues.',
          numberOfLikes: 42,
          time: 'before 2 weeks',
        ),
      ],
    ),
    Doctor(
      name: 'Dr. Sara Mohamed',
      specialty: 'Dentist',
      image: 'assets/doctor2.jpg',
      rating: 4.8,
      price: '150 pounds / examination',
      distance: '20 minutes away from you',
      status: 'Offline',
      address: '456 Elm Street, Los Angeles, CA 90001',
      experience: 5,
      numberOfPatients: 450,
      about: 'Experienced dentist specialized in cosmetic dentistry.',
      noOfReviews: 89,
      workingHours: '10:00 AM - 6:00 PM',
      Comments: [
        CommentModel(
          image: 'assets/doctor.jpg',
          name: 'Omar Youssef',
          comment:
          'Dr. Sara is amazing! She made me feel very comfortable during my visit.',
          numberOfLikes: 78,
          time: 'before 1 week',
        ),
        CommentModel(
          image: 'assets/doctor2.jpg',
          name: 'Salma Adel',
          comment:
          'Very professional and caring dentist. Highly recommended.',
          numberOfLikes: 55,
          time: 'before 3 days',
        ),
      ],
    ),
    Doctor(
      name: 'Dr. Omar Ali',
      specialty: 'Pediatrician',
      image: 'assets/doctor.jpg',
      rating: 4.2,
      price: '200 pounds / examination',
      distance: '40 minutes away from you',
      status: 'Online',
      address: '789 Oak Street, Chicago, IL 60601',
      experience: 10,
      numberOfPatients: 1000,
      about: 'Trusted pediatrician with over 10 years of experience.',
      noOfReviews: 132,
      workingHours: '8:00 AM - 4:00 PM',
      Comments: [
        CommentModel(
          image: 'assets/doctor2.jpg',
          name: 'Nourhan Tarek',
          comment:
          'Dr. Omar is wonderful with kids. My son felt very safe and happy.',
          numberOfLikes: 93,
          time: 'before 4 days',
        ),
        CommentModel(
          image: 'assets/doctor.jpg',
          name: 'Karim Fathy',
          comment:
          'Very attentive and experienced doctor. Explained everything clearly.',
          numberOfLikes: 61,
          time: 'before 2 weeks',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: doctors
          .map(
            (doc) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8),
              child: DotorCardItem(
                doctor: doc,
                isDoctorScreen: true,
                onTap: () {
                  Get.to(() => DoctorDetailsScreen(doctor: doc));
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
