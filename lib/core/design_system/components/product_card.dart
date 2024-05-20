import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minstock/core/common/helper/currency_formatter.dart';
import 'package:minstock/core/design_system/components/remove_product_dialog.dart';
import 'package:minstock/core/design_system/theme/app_colors.dart';
import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/features/inventory/add_product/add_product_page.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [SlideEffect(begin: Offset(0, 1), curve: Curves.easeIn), FadeEffect()],
      child: InkWell(
        onTap: () => Navigator.push(context, AddProductPage.route(selectedProduct: product)),
        onLongPress: () {
          final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
          final RenderBox itemBox = context.findRenderObject() as RenderBox;
          final Offset position = itemBox.localToGlobal(itemBox.size.bottomRight(Offset.zero), ancestor: overlay);

          showMenu(
            surfaceTintColor: Colors.black.withOpacity(.9),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              side: BorderSide(color: Colors.white.withOpacity(.5), width: .5),
            ),
            color: Colors.black.withOpacity(.9),
            context: context,
            position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
            items: [
              PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                  tileColor: Colors.black.withOpacity(.9),
                  contentPadding: EdgeInsets.zero,
                  title: const Center(
                    child: Text(
                      'Editar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, AddProductPage.route(selectedProduct: product));
                  },
                ),
              ),
              PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                  tileColor: Colors.black.withOpacity(.9),
                  contentPadding: EdgeInsets.zero,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: const Center(
                    child: Text(
                      'Excluir',
                      style: TextStyle(color: Colors.red),
                    ),
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
                                Radius.circular(10),
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
      ),
    );
  }
}
