import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../blocs/product/product_bloc.dart';
import '../models/product.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  String _generateReceiptText(List<Product> products) {
    final buffer = StringBuffer();
    buffer.writeln('Receipt');
    buffer.writeln('-------------------------');
    double total = 0;
    for (var product in products) {
      buffer.writeln('${product.name} x${product.quantity} - \$${product.totalPrice.toStringAsFixed(2)}');
      total += product.totalPrice;
    }
    buffer.writeln('-------------------------');
    buffer.writeln('Total: \$${total.toStringAsFixed(2)}');
    return buffer.toString();
  }

  void _shareReceipt(BuildContext context, List<Product> products) {
    final receiptText = _generateReceiptText(products);
    Share.share(receiptText);
  }

  void _printReceipt(List<Product> products) {
    final receiptText = _generateReceiptText(products);
    Printing.layoutPdf(onLayout: (format) async {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Text(receiptText),
        ),
      );
      return pdf.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text('No products to show.'));
            }
            final receiptText = _generateReceiptText(state.products);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(receiptText, style: const TextStyle(fontFamily: 'monospace')),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.print),
                        label: const Text('Print'),
                        onPressed: () => _printReceipt(state.products),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        onPressed: () => _shareReceipt(context, state.products),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
