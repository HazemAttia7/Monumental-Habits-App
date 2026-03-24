import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/analytics_row.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/item_footer.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/item_header.dart';

class HabitsAnalyticsSliverListItem extends StatelessWidget {
  final Habit habit;
  const HabitsAnalyticsSliverListItem({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          ItemHeader(habit: habit),
          Gap(4.h),
          Divider(color: AppColors.primaryColor.withValues(alpha: .2)),
          Gap(4.h),
          AnalyticsRow(habit: habit),
          Gap(12.h),
          ItemFooter(ratio: habit.completionRate, status: habit.status),
        ],
      ),
    );
  }
}
