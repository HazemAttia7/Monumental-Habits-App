import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

void buildNotImplementedYetDialog(
  BuildContext context, {
  required String featureName,
}) {
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      content: Text(
        '$featureName not implemented yet',
        style: AppStyles.textStyle14,
      ),
      backgroundColor: Colors.white,
    ),
  );
}
