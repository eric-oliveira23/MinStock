import 'package:minstock/core/domain/product/product_repository.dart';

class DeleteProduct {
  final ProductRepository _productRepository;

  DeleteProduct({required ProductRepository productRepository}) : _productRepository = productRepository;

  Future<void> execute(String id) async => await _productRepository.delete(id);
}
