import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CommentsSectionHeader extends StatelessWidget {
  const CommentsSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Comments",
          style: AppStyles.textStyle20.copyWith(
            color: AppColors.secondaryColor.withValues(alpha: .8),
          ),
        ),
        Text(
          "Newest First",
          style: AppStyles.textStyle14.copyWith(
            fontWeight: FontWeight.w600,
            color: Color.lerp(AppColors.primaryColor, Colors.black, .25),
          ),
        ),
      ],
    );
  }
}
