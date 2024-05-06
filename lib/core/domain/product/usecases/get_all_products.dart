import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/core/domain/product/product_repository.dart';
import 'package:minstock/core/services/product/model/product_model.dart';

class GetAllProducts {
  final ProductRepository _productRepository;

  GetAllProducts({required ProductRepository productRepository}) : _productRepository = productRepository;

  Future<List<ProductEntity>> execute() async {
    final List<ProductModel> products = await _productRepository.getAll();

    final List<ProductEntity> entities = products
        .map(
          (product) => ProductEntity(
            id: product.id,
            name: product.name,
            stockQuantity: product.stockQuantity,
            price: product.price,
            image: product.image,
          ),
        )
        .toList();

    return entities;
  }
}
