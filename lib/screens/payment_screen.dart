import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Payment History', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: PaymentTable(),
    );
  }
}

class PaymentTable extends StatelessWidget {
  const PaymentTable({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration (replace with your actual data)
    final List<Map<String, dynamic>> paymentData = [
      {
        'id': 1,
        'user': 'John Doe',
        'amount': 50.0,
        'phoneNumber': '123-456-7890',
        'date': '2023-09-28',
      },
      {
        'id': 2,
        'user': 'Jane Smith',
        'amount': 75.0,
        'phoneNumber': '987-654-3210',
        'date': '2023-09-27',
      },
      // Add more rows as needed
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('ID'),
          ),
          DataColumn(
            label: Text('User'),
          ),
          DataColumn(
            label: Text('Amount'),
          ),
          DataColumn(
            label: Text('Phone Number'),
          ),
          DataColumn(
            label: Text('Date'),
          ),
        ],
        rows: paymentData.map((data) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(data['id'].toString())),
              DataCell(Text(data['user'])),
              DataCell(Text(data['amount'].toString())),
              DataCell(Text(data['phoneNumber'])),
              DataCell(Text(data['date'])),
            ],
          );
        }).toList(),
      ),
    );
  }
}
