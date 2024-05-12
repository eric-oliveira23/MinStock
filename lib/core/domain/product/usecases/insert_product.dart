import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/core/domain/product/product_repository.dart';
import 'package:minstock/core/services/product/model/product_model.dart';

class InsertProduct {
  final ProductRepository _productRepository;

  InsertProduct({required ProductRepository productRepository}) : _productRepository = productRepository;

  Future<void> execute(ProductEntity product) async {
    final productModel = ProductModel(
      id: product.id,
      name: product.name,
      stockQuantity: product.stockQuantity,
      price: product.price,
      image: product.image,
      isActive: product.isActive,
    );

    _productRepository.insert(productModel);
  }
}
