import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Cart', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Text('Cart Content Goes Here'),
      ),
    );
  }
}
