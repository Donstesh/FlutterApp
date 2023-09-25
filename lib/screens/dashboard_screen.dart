import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Dashboard' , style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Text('DashboardScreen Content Goes Here'),
      ),
    );
  }
}