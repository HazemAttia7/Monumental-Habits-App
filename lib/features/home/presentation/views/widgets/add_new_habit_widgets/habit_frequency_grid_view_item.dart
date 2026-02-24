import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/animated_off_on_button.dart';

class HabitFrequencyGridViewItem extends StatelessWidget {
  final bool isOn;
  final String day;
  final Function(bool) onTap;

  const HabitFrequencyGridViewItem({
    super.key,
    required this.day,
    required this.isOn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      decoration: BoxDecoration(
        color: isOn
            ? AppColors.secondaryColor.withValues(alpha: .1)
            : AppColors.primaryColor.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        spacing: 10.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: AppStyles.textStyle20.copyWith(
              color: isOn ? AppColors.secondaryColor : AppColors.primaryColor,
            ),
          ),
          AnimatedOffOnButton(isOn: isOn, onTap: onTap),
        ],
      ),
    );
  }
}
