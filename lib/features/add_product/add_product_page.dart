import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minstock/core/design_system/components/opacity_animator.dart';
import 'package:minstock/core/design_system/theme/app_colors.dart';
import 'package:minstock/features/add_product/add_product_provider.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  static route() => AddProductTransition(
        page: const AddProductPage(),
      );

  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  AddProductProvider addProductProvider = AddProductProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addProductProvider,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Cadastrar produto"),
          actions: [
            CupertinoButton(
              onPressed: () async => await addProductProvider.saveProduct(context),
              child: const Text("Salvar"),
            ),
          ],
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.sp),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: ListenableBuilder(
                        listenable: addProductProvider,
                        builder: (context, _) => OpacityAnimator(
                          onTap: () async => await addProductProvider.getImage(context),
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: addProductProvider.nameController,
                          decoration: const InputDecoration(labelText: "Insira o nome do produto"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: addProductProvider.valueController,
                    decoration: const InputDecoration(
                      labelText: "Insira o valor do produto",
                      hintText: '0,00',
                      prefixText: "R\$ ",
                      prefixStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SwitchListTile(
                    title: const Text(
                      "Ativo",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: true,
                    tileColor: AppColors.grey2020,
                    shape: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: OpacityAnimator(
                    onTap: () => _showSimpleBottomSheet(context),
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
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Estoque",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
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
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("11 unidades disponíveis."),
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
    );
  }

  // b o t t o m  s h e e t s

  // stock
  Future<void> _showSimpleBottomSheet(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
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
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: addProductProvider.quantityController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 16.sp),
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                        onPressed: () {},
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
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancelar',
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
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