import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_completed_indicator.dart';
import 'package:shimmer/shimmer.dart';

class OtherUserHabitsCompletedSectionShimmer extends StatelessWidget {
  const OtherUserHabitsCompletedSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            Text(
              "HABITS PERFORMED PER WEEK".toUpperCase(),
              style: AppStyles.textStyle12,
            ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                return HabitsCompletedIndicator(
                  value: 7,
                  habitsLength: 7,
                  date: _getDate(6 - index),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  String _getDate(int index) {
    if (index == 0) return "Today";
    final now = DateTime.now().subtract(Duration(days: index));
    return "${now.day}/${now.month}";
  }
}
