import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:minstock/core/design_system/components/product_card.dart';
import 'package:minstock/features/inventory/add_product/add_product_page.dart';
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
      appBar: AppBar(
        title: const Text("MinStock"),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          controller: inventoryProvider.scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: (value) => inventoryProvider.searchProducts(value),
                  decoration: const InputDecoration(
                    hintText: "Pesquise produtos...",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.search),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFF23292C),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFF23292C),
                      ),
                    ),
                    border: OutlineInputBorder(
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
                          itemBuilder: (context, index) => ProductCard(product: value.searchedProducts[index]),
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
