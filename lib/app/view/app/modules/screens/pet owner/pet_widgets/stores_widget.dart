import 'package:flutter/material.dart';
import '../../../../../../model/food_model.dart';
import 'food_card.dart';

class StoresWidget extends StatelessWidget {
   StoresWidget({super.key});
  final List<FoodModel> foods = [
    FoodModel(
      name: "Dry Food",
      price: 20,
      unit: "pound",
      description: "Balanced and healthy nutrition for your pet at every meal",
      imagePath: "assets/food.jpg",
      discount: 20,
    ),
    FoodModel(
      name: "Wet Food",
      price: 35,
      unit: "pound",
      description: "Delicious wet food for pets",
      imagePath: "assets/food.jpg",
      discount: 40,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 284,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return FoodCard(food: foods[index],);
        },
      ),
    );
  }
}
