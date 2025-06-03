import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String subcategory;

  @HiveField(5)
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.subcategory,
    this.isFavorite = false,
  });
}
