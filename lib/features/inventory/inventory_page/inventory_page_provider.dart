import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/core/domain/product/usecases/get_all_products.dart';

class InventoryProvider extends ChangeNotifier {
  final GetAllProducts _getAllProducts;

  List<ProductEntity> _products = [];
  List<ProductEntity> get products => _products;
  set products(List<ProductEntity> value) {
    _products = value;
    notifyListeners();
  }

  InventoryProvider() : _getAllProducts = GetIt.instance<GetAllProducts>() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    products = await _getAllProducts.execute();
  }
}
