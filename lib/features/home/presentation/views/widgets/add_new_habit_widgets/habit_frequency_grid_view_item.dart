import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/animated_off_on_button.dart';

class HabitFrequencyGridViewItem extends StatelessWidget {
  const HabitFrequencyGridViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "SUN",
            style: AppStyles.textStyle20.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          AnimatedOffOnButton(onTap: () {}),
        ],
      ),
    );
  }
}
