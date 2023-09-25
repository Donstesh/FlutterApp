import 'package:flutter/material.dart';

import '../models/Product.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products; // Replace with your actual product model

  ProductListView({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.title),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          leading: Image.network(product.image),
        );
      },
    );
  }
}