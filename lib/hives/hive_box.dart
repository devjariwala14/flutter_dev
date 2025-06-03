import 'package:hive/hive.dart';
import '../model/product_model.dart';

class HiveBoxes {
  static const productBox = 'products';

  static Box<Product> getProductsBox() => Hive.box<Product>(productBox);
}
