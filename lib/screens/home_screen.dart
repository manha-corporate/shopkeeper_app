import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/product/product_bloc.dart';
import 'barcode_scanner_screen.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    context.read<AuthenticationBloc>().add(AuthenticationLoggedOut());
  }

  void _navigateToScanner(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
    );
  }

  void _navigateToProductList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProductListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopkeeper Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _logout(context),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Scan Barcode'),
                onPressed: () => _navigateToScanner(context),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.list),
                label: const Text('View Product List'),
                onPressed: () => _navigateToProductList(context),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.receipt),
                label: const Text('View Receipt'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ReceiptScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
