import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:minstock/core/design_system/theme/app_colors.dart';
import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/features/inventory/inventory_page/inventory_page_provider.dart';
import 'package:provider/provider.dart';

class RemoveProductDialog extends StatelessWidget {
  final ProductEntity productEntity;

  const RemoveProductDialog({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        SlideEffect(begin: Offset(0, 1)),
        FadeEffect(duration: Duration(milliseconds: 500)),
      ],
      child: AlertDialog(
        backgroundColor: AppColors.black1A1E,
        title: const Text(
          "Espera aí!",
          style: TextStyle(color: Colors.white),
        ),
        content: Text("Deseja mesmo excluir o produto ${productEntity.name}?"),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<InventoryProvider>(context, listen: false).removeProduct(productEntity.id);
              Navigator.pop(context);
            },
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
  }
}
