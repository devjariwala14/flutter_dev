import 'package:flutter_dev/hives/hive_box.dart';
import 'package:flutter_dev/services/api_service.dart';
import 'package:get/get.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  var categories = <Category>[].obs;
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;

  RxString selectedSubSubcategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    final data = await ApiService.fetchData();

    // Parse categories
    categories.value = (data['categories'] as List).map((cat) {
      return Category(
        id: cat['id'],
        name: cat['name'],
        subcategories: (cat['subcategories'] as List).map((sub) {
          return SubCategory(
            id: sub['id'],
            name: sub['name'],
            subSubcategories: (sub['subsubcategories'] as List).map((subsub) {
              return SubSubCategory(id: subsub['id'], name: subsub['name']);
            }).toList(),
          );
        }).toList(),
      );
    }).toList();

    // Parse and store products in Hive
    final box = HiveBoxes.getProductsBox();
    box.clear(); // For testing, clear first
    for (var p in data['products']) {
      final product = Product(
        id: p['id'],
        title: p['title'],
        price: p['price'].toDouble(),
        image: p['image'],
        subcategory: p['subcategory'],
        isFavorite: p['isFavorite'],
      );
      box.put(product.id, product);
    }

    products.value = box.values.toList();
  }

  void filterProducts(String subSubcategoryName) {
    selectedSubSubcategory.value = subSubcategoryName;
    filteredProducts.value =
        products.where((p) => p.subcategory == subSubcategoryName).toList();
  }

  void toggleFavorite(int id) {
    final box = HiveBoxes.getProductsBox();
    final product = box.get(id);
    if (product != null) {
      product.isFavorite = !product.isFavorite;
      product.save();
      filteredProducts.refresh();
    }
  }
}
