import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListviewRow extends StatefulWidget {
  const CustomListviewRow({super.key});

  @override
  State<CustomListviewRow> createState() => _CustomListviewRowState();
}

class _CustomListviewRowState extends State<CustomListviewRow> {
  final List<Map<String, dynamic>> specialties = [
    {"name": "All"},
    {"name": "Cardiology"},
    {"name": "Surgery"},
    {"name": "Nutrition"},
    {"name": "Dermatology"},
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xff01727A) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    specialties[index]['name'].toString().tr,
                    style: GoogleFonts.cairo(
                      color: isSelected ? Colors.white : const Color(0xff01727A),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
