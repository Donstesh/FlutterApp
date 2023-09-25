import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/product.dart'; // Replace with your actual product model
import 'bloc/product_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ProductBloc(httpClient: http.Client()),
        child: ProductListScreen(),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);

    // Dispatch the FetchProducts event when the widget is built
    productBloc.add(FetchProducts());

    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitialState || state is ProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoadedState) {
            return ProductListView(products: state.products);
          } else if (state is ProductErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container(); // Handle other states if necessary
        },
      ),
    );
  }
}

class ProductListView extends StatelessWidget {
  final List<Product> products;

  ProductListView({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          leading: Image.network(product.imageUrl),
        );
      },
    );
  }
}
