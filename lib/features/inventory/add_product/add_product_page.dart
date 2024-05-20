import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minstock/core/design_system/components/opacity_animator.dart';
import 'package:minstock/core/design_system/theme/app_colors.dart';
import 'package:minstock/core/domain/product/entities/product_entity.dart';
import 'package:minstock/features/inventory/add_product/add_product_provider.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  static route({ProductEntity? selectedProduct}) => AddProductTransition(
        page: AddProductPage(selectedProduct: selectedProduct),
      );

  final ProductEntity? selectedProduct;

  const AddProductPage({super.key, this.selectedProduct});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late AddProductProvider addProductProvider;

  @override
  void initState() {
    addProductProvider = AddProductProvider(widget.selectedProduct);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addProductProvider,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.selectedProduct != null ? widget.selectedProduct?.name ?? "" : "Cadastrar produto"),
          actions: [
            CupertinoButton(
              onPressed: () async => await addProductProvider.saveProduct(context),
              child: const Text("Salvar"),
            ),
          ],
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: ListenableBuilder(
              listenable: addProductProvider,
              builder: (context, _) => Column(
                children: [
                  SizedBox(height: 16.sp),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: OpacityAnimator(
                          // onTap: () async => await addProductProvider.getImage(context),
                          onTap: () => _showCameraBottomSheet(context),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.grey2020,
                              border: Border.all(color: AppColors.black1A1E),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: addProductProvider.image == null
                                ? const Icon(
                                    CupertinoIcons.photo,
                                    color: Colors.white,
                                  )
                                : ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    child: Image.memory(
                                      addProductProvider.image!,
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextField(
                            controller: addProductProvider.nameController,
                            inputFormatters: [LengthLimitingTextInputFormatter(15)],
                            decoration: const InputDecoration(labelText: "Insira o nome do produto"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: addProductProvider.valueController,
                      inputFormatters: [LengthLimitingTextInputFormatter(12)],
                      decoration: const InputDecoration(
                        labelText: "Insira o valor do produto",
                        hintText: '0,00',
                        prefixText: "R\$ ",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListTileTheme(
                      child: SwitchListTile(
                        title: Text(
                          addProductProvider.activeProduct ? "Ativo" : "Inativo",
                          style: TextStyle(
                            color: addProductProvider.activeProduct ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        value: addProductProvider.activeProduct,
                        onChanged: (value) => addProductProvider.handleActiveSwitch(value),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: OpacityAnimator(
                      onTap: () => _showQuantityBottomSheet(context),
                      child: Card(
                        surfaceTintColor: Colors.transparent,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            side: BorderSide(color: AppColors.black1A1E)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Estoque",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            Divider(color: AppColors.black1A1E),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(30, 8, 30, 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "11 unidades disponíveis.",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // b o t t o m  s h e e t s

  // stock
  Future<void> _showQuantityBottomSheet(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return StockQuantityBottomSheet(addProductProvider: addProductProvider);
      },
    );
  }

  Future<void> _showCameraBottomSheet(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            0,
            0,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text("Selecione o modo de foto."),
              ),
              const SizedBox(height: 15),
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: const Text("Galeria"),
                    onTap: () {},
                    tileColor: Colors.transparent,
                  ),
                  ListTile(
                    title: const Text("Tirar foto"),
                    onTap: () {},
                    tileColor: Colors.transparent,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

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

class AddProductTransition extends PageRouteBuilder {
  final Widget page;

  AddProductTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0, 1);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
