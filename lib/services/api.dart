import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Product.dart';

class ProductService {
  final String baseUrl = 'https://127.0.0.1:8000/api/products'; // Replace with your API URL

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
