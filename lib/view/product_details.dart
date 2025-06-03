import 'package:flutter/material.dart';
import 'package:flutter_dev/controller/product_controller.dart';
import 'package:flutter_dev/model/product_model.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  ProductDetails({super.key, required this.product});
  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 200,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Price: \$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "Subcategory: ${product.subcategory}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Favorite: "),
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
          ],
        ),
      ),
    );
  }
}
