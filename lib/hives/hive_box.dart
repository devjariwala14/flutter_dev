import 'package:hive/hive.dart';
import '../model/product_model.dart';

class HiveBoxes {
  static Box<Product> getProductsBox() => Hive.box<Product>('products');
}
