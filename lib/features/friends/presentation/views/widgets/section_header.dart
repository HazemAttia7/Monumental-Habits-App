import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  final VoidCallback viewAll;
  const SectionHeader({super.key, required this.text, required this.viewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
        ),
        CustomClickableText(
          text: "View All",
          fontSize: 14.sp,
          textColor: AppColors.secondaryColor,
          onTap: viewAll,
        ),
      ],
    );
  }
}
