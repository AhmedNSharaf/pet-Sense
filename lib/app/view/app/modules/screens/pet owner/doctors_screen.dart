import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_sense/app/view/app/modules/screens/pet%20owner/custom_app_bar.dart';
import 'package:pet_sense/app/view/app/modules/screens/pet%20owner/doctors_widgets/doctors_list.dart';
import 'custom_search.dart';
import 'doctors_widgets/custom_listview_row.dart';
import 'pet_widgets/custom_section_label.dart';
import 'pet_widgets/suggestions_widget.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             CustomAppBar(title: 'Doctors',),
              CustomSearch(needFilter: true,),
              const SizedBox(height: 15),
              CustomSectionLabel(label: 'Choose a specialty'.tr),
              const SizedBox(height: 15),
              CustomListviewRow(),
              DoctorsList(),
              CustomSectionLabel(label: 'suggestion'.tr),
              const SizedBox(height: 20),
              SuggestionsWidget(label: 'discount_offer'.tr),
            ],
          ),
        ),
      ),
    );
  }
}
