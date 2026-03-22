import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_completed_date.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/performed_habits_count_list.dart';

class HabitsCompletedSection extends StatelessWidget {
  const HabitsCompletedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("HABITS PERFORMED PER DAY", style: AppStyles.textStyle12),
        Gap(8.h),
        const PerformedHabitsCountList(),
        Gap(12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: const HabitsCompletedDate(),
        ),
      ],
    );
  }
}
