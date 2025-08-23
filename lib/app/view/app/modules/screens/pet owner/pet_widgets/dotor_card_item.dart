import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../model/doctor_model.dart';
import '../custom_elvated_button.dart';

class DotorCardItem extends StatelessWidget {
  bool isDoctorScreen = false;
  Function()? onTap;
  final Doctor doctor;

  DotorCardItem({super.key, required this.doctor, this.isDoctorScreen = false,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
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
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 27.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          doctor.image,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    doctor.status == 'Offline' ? const SizedBox() : Positioned(
                      bottom: 0,
                      right: 3,
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0XFF04E70C),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 26),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialty.tr,
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffA0A0A0),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 45,
                  height: 26,
                  decoration: BoxDecoration(
                    color: const Color(0xffFDFDFD),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xffFFD93D),
                        size: 17,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        doctor.rating.toString(),
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffDFF7F8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isDoctorScreen?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text("Status",
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff333333),
                            ),),
                            Text(doctor.status,
                              style: GoogleFonts.cairo(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff333333),
                              ),
                            )
                          ],
                        ) :Text(
                      doctor.distance,
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff333333),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: VerticalDivider(
                        thickness: 1,
                        color: Color(0xffA0A0A0),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price'.tr,
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff333333),
                          ),
                        ),
                        Text(
                          doctor.price.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff333333),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomElvatedButton(onTap: onTap,text: 'Details',),
          ],
        ),
      ),
    );
  }
}
