import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'package:stesh_app_api/models/product.dart'; // Replace with your actual product model import

// Define the events
abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {} // Event to fetch products

// Define the states
abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final http.Client httpClient;

  ProductBloc({required this.httpClient}) : super(ProductInitialState()) {
    // Register event handlers here
    on<FetchProducts>(_fetchProducts);
  }

  void _fetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      final response = await httpClient.get(Uri.parse('http://localhost:8000/api/products')); // Replace with your API endpoint
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Product> products = jsonData.map((data) => Product.fromJson(data)).toList();
        emit(ProductLoadedState(products: products));
      } else {
        emit(ProductErrorState(error: 'Failed to load products'));
      }
    } catch (e) {
      emit(ProductErrorState(error: 'An error occurred: $e'));
    }
  }

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    // Handle other events if necessary
  }
}
