import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/core/domain/product/usecases/delete_product.dart';
import 'package:minstock/core/domain/product/usecases/get_all_products.dart';

class InventoryProvider extends ChangeNotifier {
  final GetAllProducts _getAllProducts;
  final DeleteProduct _deleteProduct;

  ScrollController scrollController = ScrollController();

  List<ProductEntity> _products = [];
  List<ProductEntity> get products => _products;
  set products(List<ProductEntity> value) {
    _products = value;
    notifyListeners();
  }

  List<ProductEntity> _searchedProducts = [];
  List<ProductEntity> get searchedProducts => _searchedProducts;
  set searchedProducts(List<ProductEntity> value) {
    _searchedProducts = value;
    notifyListeners();
  }

  bool _visibleFab = true;
  bool get visibleFab => _visibleFab;

  InventoryProvider()
      : _getAllProducts = GetIt.instance<GetAllProducts>(),
        _deleteProduct = GetIt.instance<DeleteProduct>() {
    fetchProducts();

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_visibleFab) {
          _visibleFab = false;
          notifyListeners();
        }
      } else {
        if (!_visibleFab) {
          _visibleFab = true;
          notifyListeners();
        }
      }
    });
  }

  Future<void> fetchProducts() async {
    products = await _getAllProducts.execute();
    searchedProducts = products;
  }

  Future<void> removeProduct(String id) async {
    await _deleteProduct.execute(id);
    await fetchProducts();
  }

  void searchProducts(String searchText) {
    List<ProductEntity> results = [];
    if (searchText.isEmpty) {
      results = _products;
    } else {
      results = _products.where((element) => element.name.toLowerCase().contains(searchText.toLowerCase())).toList();
    }

    _searchedProducts = results;
    notifyListeners();
  }
}
