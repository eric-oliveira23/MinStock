import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:minstock/core/common/helper/currency_formatter.dart';
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
  late final InventoryProvider inventoryProvider;

  @override
  void initState() {
    inventoryProvider = Provider.of<InventoryProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          controller: inventoryProvider.scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: (value) => inventoryProvider.searchProducts(value),
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
                      builder: (_, value, __) {
                        if (value.searchedProducts.isEmpty) {
                          final size = MediaQuery.of(context).size;

                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Animate(
                              effects: const [FadeEffect(delay: Duration(milliseconds: 200))],
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    "Oooops!",
                                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 20),
                                  Animate(
                                      effects: const [ScaleEffect(delay: Duration(milliseconds: 500))],
                                      child: Lottie.asset('assets/anim/empty_list.json', width: size.width / 2)),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Parece que não há movimento por aqui...\nTente mudar a pesquisa, ou adicione um novo produto :)",
                                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          itemCount: value.searchedProducts.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Animate(
                              effects: const [SlideEffect(begin: Offset(1, 0))],
                              child: ProductTile(product: value.searchedProducts[index])),
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey.shade800,
                            thickness: .7,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: inventoryProvider,
        builder: (context, child) => IgnorePointer(
          ignoring: !inventoryProvider.visibleFab,
          child: AnimatedOpacity(
            alwaysIncludeSemantics: false,
            duration: const Duration(milliseconds: 200),
            opacity: inventoryProvider.visibleFab ? 1 : 0,
            child: FloatingActionButton(
              onPressed: () => Navigator.push(context, AddProductPage.route()),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final ProductEntity product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, AddProductPage.route(selectedProduct: product)),
      onLongPress: () {
        final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
        final RenderBox itemBox = context.findRenderObject() as RenderBox;
        final Offset position = itemBox.localToGlobal(itemBox.size.bottomRight(Offset.zero), ancestor: overlay);

        showMenu(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            side: BorderSide(color: Colors.white.withOpacity(.5), width: .5),
          ),
          color: Colors.black.withOpacity(.9),
          context: context,
          position: RelativeRect.fromLTRB(
            position.dx,
            position.dy,
            position.dx,
            position.dy,
          ),
          items: [
            PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                contentPadding: const EdgeInsets.all(5),
                leading: const Icon(Icons.edit, color: Colors.white),
                title: const Text(
                  'Editar',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                contentPadding: const EdgeInsets.all(5),
                leading: const Icon(Icons.delete, color: Colors.white),
                title: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => RemoveProductDialog(productEntity: product),
                  );
                },
              ),
            ),
          ],
        );
      },
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    product.image == null
                        ? Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.grey2020,
                              border: Border.all(color: AppColors.black1A1E),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.photo,
                              color: Colors.white,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            child: Image.memory(
                              product.image!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
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
                  CurrencyFormatter.formatAsBRL(product.price),
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
