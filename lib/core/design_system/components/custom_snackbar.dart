import 'package:flutter/material.dart';
import 'package:minstock/core/design_system/theme/app_colors.dart';

void showSnackBar(BuildContext context, Widget content) {
  final snackBar = SnackBar(
    content: content,
    backgroundColor: AppColors.black1A1E,
    elevation: 0,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
