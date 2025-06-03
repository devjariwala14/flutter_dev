import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';
import '../controller/product_controller.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final controller = Get.find<ProductController>();

  ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(product.image, height: 100, width: 100),
          Text(product.title),
          Text('\$${product.price}'),
          IconButton(
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () => controller.toggleFavorite(product.id),
          )
        ],
      ),
    );
  }
}
