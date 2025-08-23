import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_sense/app/model/food_model.dart';

import '../custom_elvated_button.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: 191,
        height: 284,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      food.imagePath,
                      width: 175,
                      height: 132,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (food.discount > 0) // يظهر لو في خصم
                    Positioned(
                      child: Container(
                        width: 64,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: Color(0xff01727A),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "discount ${food.discount}%".tr,
                            style: GoogleFonts.cairo(
                              color: const Color(0xffFDFDFD),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    food.name.tr,
                    style: GoogleFonts.cairo(
                      color: const Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    food.price.toString().tr,
                    style: GoogleFonts.cairo(
                      color: const Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    " ${food.unit}".tr,
                    style: GoogleFonts.cairo(
                      color: const Color(0xffA0A0A0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                food.description.tr,
                style: GoogleFonts.cairo(
                  color: const Color(0xffA0A0A0),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              CustomElvatedButton(onTap: () {}, needArrow: false,needCart: true,text: 'Add to cart',),
            ],
          ),
        ),
      ),
    );
  }
}
