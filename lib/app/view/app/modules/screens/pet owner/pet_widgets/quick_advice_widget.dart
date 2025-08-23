import 'package:flutter/material.dart';
import 'package:pet_sense/app/model/quick_advice_model.dart';
import 'quick_advice_card.dart';

class QuickAdviceWidget extends StatelessWidget {
   QuickAdviceWidget({super.key});
  List<QuickAdviceModel> advices = [
    QuickAdviceModel(
      icon: Icons.water_drop,
      message: "Make sure your pet drinks enough water today.",
    ),
    QuickAdviceModel(
      icon: Icons.pets,
      message: "Take your pet for a short walk.",
    ),
    QuickAdviceModel(
      icon: Icons.food_bank,
      message: "Don’t forget to give your pet a healthy meal.",
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
       shrinkWrap: true,
        itemCount: advices.length,
        itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: QuickAdviceCard(advice: advices[index],),
      );
    });
  }
}
