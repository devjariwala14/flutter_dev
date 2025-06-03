import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive/hive.dart';

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

  late RxBool isFavoriteRx;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.subcategory,
    this.isFavorite = false,
  }) {
    isFavoriteRx = isFavorite.obs;

    // Optional: Update plain bool when reactive value changes
    isFavoriteRx.listen((val) {
      isFavorite = val;
      save(); // Save to Hive if needed
    });
  }
}
