import 'package:get_it/get_it.dart';
import 'package:minstock/core/domain/product/usecases/get_all_products.dart';
import 'package:minstock/core/domain/product/usecases/insert_product.dart';
import 'package:minstock/core/domain/product/usecases/update_product.dart';
import 'package:minstock/core/services/product/datasource/local/database.dart';
import 'package:minstock/core/services/product/datasource/local/database_impl.dart';
import 'package:minstock/core/services/product/product_repository_impl.dart';

void injectDependencies() {
  final GetIt getIt = GetIt.instance;

  getIt.registerLazySingleton<Database>(() => DatabaseImpl());
  getIt.registerLazySingleton(() => GetAllProducts(productRepository: ProductRepositoryImpl()));
  getIt.registerLazySingleton(() => InsertProduct(productRepository: ProductRepositoryImpl()));
  getIt.registerLazySingleton(() => UpdateProduct(productRepository: ProductRepositoryImpl()));
}
