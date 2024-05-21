import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minstock/features/inventory/add_product/add_product_provider.dart';

class StockQuantityBottomSheet extends StatelessWidget {
  const StockQuantityBottomSheet({
    super.key,
    required this.addProductProvider,
  });

  final AddProductProvider addProductProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: addProductProvider.quantityController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(3)
              ],
              decoration: InputDecoration(
                labelText: "Insira a quantidade de estoque",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.remove, color: Colors.red),
                    onPressed: () => addProductProvider.decrementStockQuantity(),
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    onPressed: () => addProductProvider.incrementStockQuantity(),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Fechar',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
