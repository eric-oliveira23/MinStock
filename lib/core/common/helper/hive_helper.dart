import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:minstock/core/services/product/model/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path_helper;

class HiveHelper {
  static Future<void> initHive({String? subDir}) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) return;

    var appDir = await getApplicationDocumentsDirectory();
    Hive.init(path_helper.join(appDir.path, subDir));
  }

  static void registerAdapters() {
    Hive.registerAdapter(ProductModelAdapter());
  }
}
