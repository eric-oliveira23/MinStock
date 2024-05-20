import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minstock/core/design_system/components/custom_snackbar.dart';
import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/core/domain/product/usecases/insert_product.dart';
import 'package:minstock/core/domain/product/usecases/update_product.dart';
import 'package:minstock/features/inventory/inventory_page/inventory_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddProductProvider extends ChangeNotifier {
  final InsertProduct _insertProduct;
  final UpdateProduct _updateProduct;

  final ProductEntity? selectedProduct;

  final _picker = ImagePicker();

  Uint8List? _image;
  Uint8List? get image => _image;

  bool _activeProduct = false;
  bool get activeProduct => _activeProduct;

  int _stockQuantity = 0;
  int get stockQuantity => _stockQuantity;

  AddProductProvider(this.selectedProduct)
      : _insertProduct = GetIt.instance<InsertProduct>(),
        _updateProduct = GetIt.instance<UpdateProduct>() {
    if (selectedProduct != null) {
      getProductInfos();
    }
  }

  // t e x t  c o n t r o l l e r s

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _quantityController = TextEditingController();
  TextEditingController get quantityController => _quantityController;

  final TextEditingController _valueController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  TextEditingController get valueController => _valueController;

  Future getImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = await File(pickedFile.path).readAsBytes();
      notifyListeners();
    } else {
      if (context.mounted) {
        showSnackBar(context, const Text("Nenhuma imagem foi selecionada."));
      }
    }
  }

  void handleActiveSwitch(bool value) {
    _activeProduct = value;
    notifyListeners();
  }

  void incrementStockQuantity() {
    _stockQuantity++;
    _quantityController.text = _stockQuantity.toString();
  }

  void decrementStockQuantity() {
    if (_stockQuantity == 0) return;
    _stockQuantity--;
    _quantityController.text = _stockQuantity.toString();
  }

  void getProductInfos() {
    _nameController.text = selectedProduct?.name ?? "";
    _valueController.text = (selectedProduct?.price ?? 0).toString();
    _quantityController.text = (selectedProduct?.stockQuantity ?? 0).toString();
    _stockQuantity = (selectedProduct?.stockQuantity ?? 0);
    _image = selectedProduct?.image;
    _activeProduct = selectedProduct?.isActive ?? false;
  }

  Future<void> saveProduct(BuildContext context) async {
    if (nameController.text.isEmpty || valueController.text == '0.00') {
      showSnackBar(context, const Text("Informe os dados corretamente."));
      return;
    }

    final product = ProductEntity(
      id: selectedProduct?.id ?? const Uuid().v4(),
      name: nameController.text,
      stockQuantity: _stockQuantity,
      price: double.parse(valueController.text.replaceAll(RegExp(r'[^0-9.]'), '')),
      isActive: _activeProduct,
      image: _image,
    );

    selectedProduct != null ? await _updateProduct.execute(product) : await _insertProduct.execute(product);

    if (context.mounted) {
      await Provider.of<InventoryProvider>(context, listen: false).fetchProducts();

      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
