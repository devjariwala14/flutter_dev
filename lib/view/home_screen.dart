import 'package:flutter/material.dart';
import 'package:flutter_dev/widgets/product_card.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(ProductController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ecommerce App')),
      drawer: Drawer(
        child: Obx(() {
          return ListView(
            children: controller.categories.map((category) {
              return ExpansionTile(
                title: Text(category.name),
                children: category.subcategories.map((sub) {
                  return ExpansionTile(
                    title: Text(sub.name),
                    children: sub.subSubcategories.map((subsub) {
                      return ListTile(
                        title: Text(subsub.name),
                        onTap: () {
                          Navigator.pop(context);
                          controller.filterProducts(subsub.name);
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              );
            }).toList(),
          );
        }),
      ),
      body: Obx(() {
        return (controller.filteredProducts.isNotEmpty)
            ? GridView.count(
                crossAxisCount: controller.filteredProducts.length,
                children: controller.filteredProducts
                    .map((product) => ProductCard(product))
                    .toList(),
              )
            : Center(
                child: Text('Please a category to view products'),
              );
      }),
    );
  }
}
