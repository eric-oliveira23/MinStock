import 'package:hive/hive.dart';
import 'package:minstock/core/services/product/datasource/local/database.dart';
import 'package:minstock/core/services/product/model/product_model.dart';

class DatabaseImpl implements Database {
  final String _productsBoxKey = "product_box_key";

  @override
  Future<bool> delete(String id) async {
    final box = await Hive.openBox<ProductModel>(_productsBoxKey);

    int index = box.values.toList().indexWhere((element) => element.id == id);

    if (index != -1) {
      await box.deleteAt(index);
    }

    return index != 1;
  }

  @override
  Future<List<ProductModel>> getAll() async {
    final box = await Hive.openBox<ProductModel>(_productsBoxKey);
    return box.values.toList();
  }

  @override
  Future<List<ProductModel>> insert(ProductModel model) async {
    final box = await Hive.openBox<ProductModel>(_productsBoxKey);
    await box.add(model);

    return getAll();
  }

  @override
  Future<List<ProductModel>> update(ProductModel model) async {
    final box = await Hive.openBox<ProductModel>(_productsBoxKey);

    int index = box.values.toList().indexWhere((element) => element.id == model.id);

    if (index != -1) {
      await box.putAt(index, model);
    }

    return getAll();
  }
}
