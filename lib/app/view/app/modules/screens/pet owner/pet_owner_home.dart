// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_sense/app/view/app/modules/screens/pet%20owner/doctors_screen.dart';

import 'pet_widgets/custom_section_label.dart';
import 'pet_widgets/doctors_general_widget.dart';
import 'pet_widgets/quick_advice_widget.dart';
import 'pet_widgets/stores_widget.dart';
import 'pet_widgets/suggestions_widget.dart';


class PetOwnerHome extends StatelessWidget {
  PetOwnerHome({super.key});
  List<Map<String, dynamic>> services = [
    {'name': 'Veterinary', 'icon': 'assets/Vector.svg'},
    {'name': 'Pet Store', 'icon': 'assets/cart.svg'},
    {'name': 'Sitters', 'icon': 'assets/Baby worker.svg'},
  ];
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff01727A),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/download.jpeg'),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Fix alignment
                    children: [
                      Text(
                        'Welcome Ali',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                      Text(
                        'Pet Owner Of (Rex)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_active_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// ✅ Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  cursorColor: Color(0xff01727A),
                  decoration: InputDecoration(
                    hintText: 'search_doctor_store_service'.tr,
                    hintStyle: GoogleFonts.cairo(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Color(0xff01727A),
                    ),
                  ),
                ),
              ),
            ),

            /// ✅ Grid View (Fixed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                shrinkWrap: true, // Fix overflow
                physics:
                    const NeverScrollableScrollPhysics(), // Disable inner scroll
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 3, // Add limit
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                    if (services[index]['name'] == 'Veterinary') {
                      Get.to(() => DoctorsScreen());
                    } else if (services[index]['name'] == 'Pet Store') {
                      Get.to(() => null);
                    } else if (services[index]['name'] == 'Sitters') {
                      Get.to(() => null);
                    }
                  },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 1,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              services[index]['icon'],
                              height: 25, // optional size
                              width: 25, // optional size
                              colorFilter: const ColorFilter.mode(
                                Color(0xff01727A),
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              services[index]['name'],
                              style: TextStyle(
                                color: Color(0xff01727A),
                                fontSize: 16,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            CustomSectionLabel(label: 'suggestion'.tr),
            const SizedBox(height: 20),
            SuggestionsWidget(label: 'discount_offer'.tr),
            const SizedBox(height: 20),
            SuggestionsWidget(label: 'nearest_doctor'.tr),
            const SizedBox(height: 20),
            CustomSectionLabel(label: 'nearest_doctors'.tr),
            DoctorsGeneralWidget(),
            const SizedBox(height: 10),
            CustomSectionLabel(label: 'Nearest Stores'.tr),
            const SizedBox(height: 5),
            StoresWidget(),
            const SizedBox(height: 20),
            CustomSectionLabel(label: 'Quick advice'.tr),
            QuickAdviceWidget(),
            const SizedBox(height: 20),
          ],
        ),
    );
  }
}
