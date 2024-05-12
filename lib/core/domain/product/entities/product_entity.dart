import 'dart:typed_data';

class ProductEntity {
  String id;
  String name;
  int stockQuantity;
  double price;
  Uint8List? image;
  bool isActive;

  ProductEntity({
    required this.id,
    required this.name,
    required this.stockQuantity,
    required this.price,
    required this.isActive,
    this.image,
  });
}
