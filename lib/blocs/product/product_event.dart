part of 'product_bloc.dart';

abstract class ProductEvent {}

class AddProduct extends ProductEvent {
  final Product product;

  AddProduct(this.product);
}

class UpdateProductQuantity extends ProductEvent {
  final String barcode;
  final int quantity;

  UpdateProductQuantity(this.barcode, this.quantity);
}

class RemoveProduct extends ProductEvent {
  final String barcode;

  RemoveProduct(this.barcode);
}

class ClearProducts extends ProductEvent {}
