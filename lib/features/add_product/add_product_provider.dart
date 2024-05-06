import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minstock/core/design_system/components/custom_snackbar.dart';
import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/core/domain/product/usecases/insert_product.dart';
import 'package:minstock/features/inventory/inventory_page/inventory_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddProductProvider extends ChangeNotifier {
  final InsertProduct _insertProduct;

  final _picker = ImagePicker();

  Uint8List? _image;
  Uint8List? get image => _image;

  final bool _activeProduct = false;
  bool get activeProduct => _activeProduct;
  set activeProduct(bool value) {
    activeProduct = value;
    notifyListeners();
  }

  final int _stockQuantity = 0;
  int get stockQuantity => _stockQuantity;
  set stockQuantity(int value) {
    stockQuantity = value;
    notifyListeners();
  }

  AddProductProvider() : _insertProduct = GetIt.instance<InsertProduct>();

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

  Future<void> saveProduct(BuildContext context) async {
    await _insertProduct.execute(
      ProductEntity(
        id: const Uuid().v4(),
        name: nameController.text,
        stockQuantity: 1,
        price: double.parse(valueController.text),
        isActive: activeProduct,
        image: _image,
      ),
    );

    if (context.mounted) {
      await Provider.of<InventoryProvider>(context, listen: false).fetchProducts();

      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
