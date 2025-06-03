import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, Map<String, List<String>>> categoryTree = {
    "Electronics": {
      "Phones": ["Android", "iPhone"],
      "Laptops": ["Gaming", "Business"]
    },
    "Fashion": {
      "Men": ["Shirts", "Jeans"],
      "Women": ["Dresses", "Tops"]
    }
  };

  String? selectedSubSubCategory;
  List<Map<String, dynamic>> products = [];
  late Box favoritesBox;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box('favorites');
  }

  Future<void> fetchProducts(String category) async {
    setState(() {
      selectedSubSubCategory = category;
      products = [];
    });

    final url =
        Uri.parse("https://mocki.io/v1/cfa1ca14-b058-4b1b-9589-af167ed16f37");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        products = data.map((e) => e as Map<String, dynamic>).toList();
      });
    }
  }

  bool isFavorite(String id) {
    return favoritesBox.containsKey(id);
  }

  void toggleFavorite(Map<String, dynamic> product) {
    final id = product['id'].toString();
    setState(() {
      if (isFavorite(id)) {
        favoritesBox.delete(id);
      } else {
        favoritesBox.put(id, product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Explorer")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Categories", style: TextStyle(color: Colors.white)),
            ),
            ...categoryTree.entries.map((mainCat) {
              return ExpansionTile(
                title: Text(mainCat.key),
                children: mainCat.value.entries.map((subCat) {
                  return ExpansionTile(
                    title: Text(subCat.key),
                    children: subCat.value.map((subSubCat) {
                      return ListTile(
                        title: Text(subSubCat),
                        onTap: () {
                          Navigator.pop(context);
                          fetchProducts(subSubCat);
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
      body: selectedSubSubCategory == null
          ? const Center(child: Text("Please select a category"))
          : products.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final id = product['id'].toString();
                    return ProductCard(
                      product: product,
                      isFavorite: isFavorite(id),
                      onFavoriteToggle: () => toggleFavorite(product),
                    );
                  },
                ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              product["image"] ?? "",
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product["title"] ?? "",
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text("\$${product["price"]}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red),
                    onPressed: onFavoriteToggle,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
