import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';

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
        CustomClickableText(
          text: "Newest First",
          fontSize: 14.sp,
          textColor: Color.lerp(AppColors.primaryColor, Colors.black, .25),
          onTap: () {
            // TODO : change to oldest first - most liked
          },
        ),
      ],
    );
  }
}
