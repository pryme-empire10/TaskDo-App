import 'package:flutter/material.dart';

import '../consts/colors.dart';

void showSnackBar(context, String text, EdgeInsetsGeometry margin) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0.0,
      backgroundColor: AppColors.blackColor,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      content: Text(text),
      dismissDirection: DismissDirection.none,
      margin: margin,
    ),
  );
}
