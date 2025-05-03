import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<AddProduct>((event, emit) {
      final currentState = state;
      if (currentState is ProductLoaded) {
        final products = List<Product>.from(currentState.products);
        final index = products.indexWhere((p) => p.barcode == event.product.barcode);
        if (index >= 0) {
          final existingProduct = products[index];
          products[index] = existingProduct.copyWith(quantity: existingProduct.quantity + event.product.quantity);
        } else {
          products.add(event.product);
        }
        emit(ProductLoaded(products));
      } else {
        emit(ProductLoaded([event.product]));
      }
    });

    on<UpdateProductQuantity>((event, emit) {
      final currentState = state;
      if (currentState is ProductLoaded) {
        final products = currentState.products.map((product) {
          if (product.barcode == event.barcode) {
            return product.copyWith(quantity: event.quantity);
          }
          return product;
        }).toList();
        emit(ProductLoaded(products));
      }
    });

    on<RemoveProduct>((event, emit) {
      final currentState = state;
      if (currentState is ProductLoaded) {
        final products = currentState.products.where((product) => product.barcode != event.barcode).toList();
        emit(ProductLoaded(products));
      }
    });

    on<ClearProducts>((event, emit) {
      emit(ProductLoaded([]));
    });
  }
}
