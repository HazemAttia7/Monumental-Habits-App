import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class DeleteDialogMessage extends StatelessWidget {
  final String itemLabel, collectionLabel;
  const DeleteDialogMessage({
    super.key,
    required this.itemLabel,
    required this.collectionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppStyles.textStyle16.copyWith(
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
        children: [
          const TextSpan(text: 'Are you sure you want to remove\n'),
          TextSpan(
            text: '"$itemLabel"',
            style: AppStyles.textStyle16.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: ' from your $collectionLabel?'),
        ],
      ),
    );
  }
}
