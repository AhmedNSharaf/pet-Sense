import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_sense/app/model/comment_model.dart';

class DoctorReviews extends StatelessWidget {
  final List<CommentModel> comments;
  const DoctorReviews({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments',
            style: GoogleFonts.cairo(
              color: Color(0xff333333),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: comments.map((comment) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffFDFDFD),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(comment.image),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          comment.name,
                          style: GoogleFonts.cairo(
                            color: const Color(0xff333333),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      comment.comment,
                      style: GoogleFonts.cairo(
                        color: const Color(0xffA0A0A0),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border_outlined,
                          color: const Color(0xffFF6F61),
                          size: 16,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          '${comment.numberOfLikes}',
                          style: GoogleFonts.cairo(
                            color: const Color(0xff333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          comment.time,
                          style: GoogleFonts.cairo(
                            color: const Color(0xffA0A0A0),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
