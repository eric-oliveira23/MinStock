import 'dart:convert';
import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int stockQuantity;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final Uint8List? image;

  @HiveField(5)
  final bool isActive;

  ProductModel({
    required this.id,
    required this.name,
    required this.stockQuantity,
    required this.price,
    required this.isActive,
    this.image,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    int? stockQuantity,
    double? price,
    Uint8List? image,
    bool? isActive,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      price: price ?? this.price,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'stockQuantity': stockQuantity,
      'price': price,
      'image': image,
      'isActive': isActive,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      stockQuantity: map['stockQuantity'] as int,
      price: map['price'] as double,
      image: map['image'] as Uint8List,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, stockQuantity: $stockQuantity, price: $price, image: $image)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.stockQuantity == stockQuantity &&
        other.price == price &&
        other.isActive == isActive &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ stockQuantity.hashCode ^ price.hashCode ^ image.hashCode ^ isActive.hashCode;
  }
}
