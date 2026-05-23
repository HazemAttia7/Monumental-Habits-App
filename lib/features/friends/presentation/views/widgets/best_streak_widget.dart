import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class BestStreakWidget extends StatelessWidget {
  final int bestStreak;
  const BestStreakWidget({super.key, required this.bestStreak});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              FontAwesomeIcons.fireFlameCurved,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
            Gap(4.w),
            Text(
              bestStreak.toString(),
              style: AppStyles.textStyle20.copyWith(color: Colors.black),
            ),
          ],
        ),
        Text(
          "Best Streak",
          style: AppStyles.textStyle14.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
