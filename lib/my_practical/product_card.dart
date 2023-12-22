import 'package:flutter/material.dart';
import 'package:my_local_storage/my_practical/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(product.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '\$${product.price}',
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  product.description,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
