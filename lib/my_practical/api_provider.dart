import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_local_storage/my_practical/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  int _page = 1;
  final int _perPage = 10;

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final url = 'https://dummyjson.com/products?limit=$_perPage&skip=${(_page - 1) * _perPage}';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body)['products'] as List;

    _products = data.map((p) => Product.fromJson(p)).toList();
    notifyListeners();
  }

  void nextPage() {
    _page++;
    fetchProducts();
  }
}