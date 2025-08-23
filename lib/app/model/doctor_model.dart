import 'package:pet_sense/app/model/comment_model.dart';

class Doctor {
  final String name;
  final String specialty;
  final String image;
  final double rating;
  final String price;
  final String distance;
  final String status;
  final String address;
  final num numberOfPatients;
  final num experience;
  final String about;
  final num noOfReviews;
  final String workingHours;
  final List<CommentModel> Comments;

  Doctor({
    required this.name,
    required this.specialty,
    required this.image,
    required this.rating,
    required this.price,
    required this.distance,
    required this.status,
    required this.address,
    required this.numberOfPatients,
    required this.experience,
    required this.about,
    required this.noOfReviews,
    required this.workingHours,
    required this.Comments,
  });
}
