class FoodModel {
  final String name;
  final double price;
  final String unit;
  final String description;
  final String imagePath;
  final int discount;

  FoodModel({
    required this.name,
    required this.price,
    required this.unit,
    required this.description,
    required this.imagePath,
    this.discount = 0,
  });
}
