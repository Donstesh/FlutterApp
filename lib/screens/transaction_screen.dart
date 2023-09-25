import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Transactions History' , style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: TransactioTable(),
    );
  }
}

class TransactioTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration (replace with your actual data)
    final List<Map<String, dynamic>> paymentData = [
      {
        'id': 1,
        'user': 'John Doe',
        'status': 'Pending',
        'date': '2023-09-28',
      },
      {
        'id': 2,
        'user': 'Stesh Doe',
        'status': 'Pending',
        'date': '2023-09-28',
      },
      // Add more rows as needed
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text('ID'),
          ),
          DataColumn(
            label: Text('User'),
          ),
          DataColumn(
            label: Text('Status'),
          ),
          DataColumn(
            label: Text('Date'),
          )
        ],
        rows: paymentData.map((data) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(data['id'].toString())),
              DataCell(Text(data['user'])),
              DataCell(Text(data['status'].toString())),
              DataCell(Text(data['date'])),
            ],
          );
        }).toList(),
      ),
    );
  }
}
