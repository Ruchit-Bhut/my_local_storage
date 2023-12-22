import 'package:flutter/material.dart';
import 'package:my_local_storage/my_practical/api_provider.dart';
import 'package:my_local_storage/my_practical/product_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider()..fetchProducts(),
      child:  const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Products App',
        home: ProductsPage(),
      ),
    );
  }
}
