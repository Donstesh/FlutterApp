import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'models/product.dart';
import 'bloc/product_bloc.dart';

import 'screens/cart_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/transaction_screen.dart';

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
      routes: {
        '/cart': (context) => CartScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/payment': (context) => PaymentScreen(),
        '/transaction': (context) => TransactionScreen(),
      },
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
        backgroundColor: Colors.blue,
        title: Text(
          'Books List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'cart') {
                Navigator.of(context).pushNamed('/cart');
              } else if (value == 'login') {
                Navigator.of(context).pushNamed('/login');
              } else if (value == 'register') {
                Navigator.of(context).pushNamed('/register');
              } else if (value == 'payment') {
                Navigator.of(context).pushNamed('/payment');
              } else if (value == 'transaction') {
                Navigator.of(context).pushNamed('/transaction');
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                'cart',
                'login',
                'register',
                'payment',
                'transaction'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
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
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation item tap here
          if (index == 0) {
            Navigator.of(context).pushNamed('/dashboard');
          } else if (index == 1) {
            Navigator.of(context).pushNamed('/payment');
          } else if (index == 2) {
            Navigator.of(context).pushNamed('/transaction');
          } else if (index == 3) {
            Navigator.of(context).pushNamed('/login');
          }
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