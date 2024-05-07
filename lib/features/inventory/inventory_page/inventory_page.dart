import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minstock/core/design_system/components/opacity_animator.dart';
import 'package:minstock/core/design_system/theme/app_colors.dart';
import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/features/add_product/add_product_page.dart';
import 'package:minstock/features/inventory/inventory_page/inventory_page_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Pesquise produtos...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFF23292C),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFF23292C),
                      ),
                    ),
                    fillColor: AppColors.black2121,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(color: Color(0xFF23292C)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<InventoryProvider>(
                      builder: (_, value, __) => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.products.length,
                        itemBuilder: (_, index) => ProductTile(product: value.products[index]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, AddProductPage.route()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final ProductEntity product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimator(
      onTap: () => Navigator.push(context, AddProductPage.route(selectedProduct: product)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: AppColors.black2121,
          ),
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.grey2020,
                          border: Border.all(color: AppColors.black1A1E),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: product.image == null
                            ? const Icon(
                                CupertinoIcons.photo,
                                color: Colors.white,
                              )
                            : ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                child: Image.memory(
                                  product.image!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      SizedBox(width: 12.sp),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Estoque ${product.stockQuantity}",
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    product.price.toString(),
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
