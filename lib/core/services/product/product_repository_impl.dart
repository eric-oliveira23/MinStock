import 'package:get_it/get_it.dart';
import 'package:minstock/core/domain/product/product_repository.dart';
import 'package:minstock/core/services/product/datasource/local/database.dart';
import 'package:minstock/core/services/product/model/product_model.dart';

class ProductRepositoryImpl extends ProductRepository {
  final _database = GetIt.instance<Database>();

  @override
  Future<bool> delete(int id) async {
    return await _database.delete(id);
  }

  @override
  Future<List<ProductModel>> getAll() async {
    return await _database.getAll();
  }

  @override
  Future<List<ProductModel>> insert(ProductModel model) async {
    return await _database.insert(model);
  }

  @override
  Future<List<ProductModel>> update(ProductModel model) async {
    return await _database.update(model);
  }
}
