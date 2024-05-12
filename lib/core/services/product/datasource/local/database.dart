import 'package:minstock/core/services/product/model/product_model.dart';

abstract class Database {
  Future<List<ProductModel>> getAll();
  Future<List<ProductModel>> insert(ProductModel model);
  Future<List<ProductModel>> update(ProductModel model);
  Future<bool> delete(String id);
}
