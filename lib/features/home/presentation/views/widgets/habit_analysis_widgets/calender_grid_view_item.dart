import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_completion_list_view_item.dart';

class CalenderGridViewItem extends StatelessWidget {
  final Color themeColor;
  final int number;
  final enHabitDailyStatus habitCompletionState;
  final bool isActive;
  final VoidCallback? onTap;
  const CalenderGridViewItem({
    super.key,
    required this.themeColor,
    required this.number,
    this.habitCompletionState = enHabitDailyStatus.none,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47.w,
      height: 72.h,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h, top: 10.h),
      decoration: BoxDecoration(
        color: themeColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            number.toString(),
            style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(6.h),
          AspectRatio(
            aspectRatio: 1,
            child: HabitCompletionListViewItem(
              themeColor: themeColor,
              onTap: onTap ?? () {},
              isActive: isActive,
              habitCompletionState: habitCompletionState,
            ),
          ),
        ],
      ),
    );
  }
}
