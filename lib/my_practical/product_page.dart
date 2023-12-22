import 'package:flutter/material.dart';
import 'package:my_local_storage/my_practical/api_provider.dart';
import 'package:my_local_storage/my_practical/product_card.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(product: products[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.read<ProductProvider>().nextPage(),
      ),
    );
  }
}