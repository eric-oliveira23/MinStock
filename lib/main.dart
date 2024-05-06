import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minstock/core/common/helper/hive_helper.dart';
import 'package:minstock/core/design_system/theme/theme.dart';
import 'package:minstock/core/injector.dart';
import 'package:minstock/features/inventory/inventory_page/inventory_page_provider.dart';
import 'package:minstock/features/main_holder/main_holder_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await HiveHelper.initHive();
  HiveHelper.registerAdapters();

  injectDependencies();

  runApp(const MinStock());
}

class MinStock extends StatelessWidget {
  const MinStock({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InventoryProvider(), lazy: true),
      ],
      child: ScreenUtilInit(
        child: MaterialApp(
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: 'MinStock',
          theme: darkTheme,
          home: const HolderPage(),
        ),
      ),
    );
  }
}
