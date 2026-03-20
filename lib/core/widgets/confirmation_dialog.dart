import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String confirmationMessage;
  final String? confirmationTitle, confirmButtonText;
  const ConfirmationDialog({
    super.key,
    required this.onConfirm,
    this.confirmationTitle,
    required this.confirmationMessage,
    this.confirmButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        confirmationTitle ?? "Confirm",
        style: AppStyles.textStyle22.copyWith(fontWeight: FontWeight.normal),
      ),
      content: Text(confirmationMessage, style: AppStyles.textStyle14),
      actions: [
        TextButton(
          onPressed: () => GoRouter.of(context).pop(),
          child: Text("Cancel", style: AppStyles.textStyle14),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(
            confirmButtonText ?? "Confirm",
            style: AppStyles.textStyle14.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
