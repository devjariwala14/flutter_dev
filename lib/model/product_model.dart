import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double price;
  @HiveField(3)
  String image;
  @HiveField(4)
  String subcategory;
  @HiveField(5)
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.image,
      required this.subcategory,
      required this.isFavorite});
}
