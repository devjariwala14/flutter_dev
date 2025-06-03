import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/product_details.dart';
import '../model/product_model.dart';
import '../controller/product_controller.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ProductController controller = Get.find();

  ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ProductDetails(product: product)),
      child: Card(
        child: Column(
          children: [
            Image.network(
              height: 100,
              product.image,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 100,
              ),
            ),
            Text(product.title),
            Text('\$${product.price.toStringAsFixed(2)}'),
            Obx(() => IconButton(
                  icon: Icon(
                    controller.isFavorite(product.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.isFavorite(product.id)
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () => controller.toggleFavorite(product.id),
                )),
          ],
        ),
      ),
    );
  }
}
