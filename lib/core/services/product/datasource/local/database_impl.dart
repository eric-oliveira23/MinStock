import 'package:hive/hive.dart';
import 'package:minstock/core/services/product/datasource/local/database.dart';
import 'package:minstock/core/services/product/model/product_model.dart';

class DatabaseImpl implements Database {
  final String _todoBoxKey = "product_box_key";

  @override
  Future<bool> delete(int id) async {
    final box = await Hive.openBox<ProductModel>(_todoBoxKey);
    await box.delete(id);

    return true;
  }

  @override
  Future<List<ProductModel>> getAll() async {
    final box = await Hive.openBox<ProductModel>(_todoBoxKey);
    return box.values.toList();
  }

  @override
  Future<List<ProductModel>> insert(ProductModel model) async {
    final box = await Hive.openBox<ProductModel>(_todoBoxKey);
    await box.add(model);

    return getAll();
  }

  @override
  Future<List<ProductModel>> update(ProductModel model) async {
    final box = await Hive.openBox<ProductModel>(_todoBoxKey);
    await box.put(model.id, model);

    return getAll();
  }
}
