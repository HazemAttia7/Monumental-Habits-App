import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/habit_title_row.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/shimmer/habit_analytics_row_shimmer.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/item_footer.dart';
import 'package:shimmer/shimmer.dart';

class HabitsAnalyticsListItemShimmer extends StatelessWidget {
  const HabitsAnalyticsListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            HabitTitleRow(habitName: 'Habit Name', createdAt: DateTime.now()),
            Gap(4.h),
            Divider(color: AppColors.primaryColor.withValues(alpha: .2)),
            Gap(4.h),
            const HabitAnalyticsShimmer(),
            Gap(12.h),
            const ItemFooter(ratio: 100, status: enHabitStatus.completed),
          ],
        ),
      ),
    );
  }
}
