import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import '../blocs/product/product_bloc.dart';
import '../models/product.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  Future<void> _scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        // For demo, create a dummy product with scanned barcode
        final product = Product(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: 'Product ${result.rawContent}',
          barcode: result.rawContent,
          quantity: 1,
          price: 10.0, // Dummy price
        );
        context.read<ProductBloc>().add(AddProduct(product));
      }
    } catch (e) {
      // Handle error or user cancel
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _scanBarcode,
          child: const Text('Start Scanning'),
        ),
      ),
    );
  }
}
