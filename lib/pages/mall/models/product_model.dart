class ProductModel {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 0,
  });
  
  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    String? imageUrl,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
} 