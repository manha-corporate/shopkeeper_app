import 'package:flutter/material.dart';

class ReceiptHistoryScreen extends StatelessWidget {
  const ReceiptHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt History'),
      ),
      body: const Center(
        child: Text('Receipt history and reporting features will be implemented here.'),
      ),
    );
  }
}
