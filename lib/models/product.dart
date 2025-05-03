class Product {
  final String id;
  final String name;
  final String barcode;
  int quantity;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.barcode,
    this.quantity = 1,
    required this.price,
  });

  double get totalPrice => price * quantity;

  Product copyWith({
    String? id,
    String? name,
    String? barcode,
    int? quantity,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
