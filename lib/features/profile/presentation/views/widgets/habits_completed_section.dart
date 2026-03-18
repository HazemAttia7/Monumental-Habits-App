import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_completed_date.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_completed_list.dart';

class HabitsCompletedSection extends StatelessWidget {
  const HabitsCompletedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HabitsCompletedList(values: [10, 4, 2, 0, 5, 1, 7]),// TODO : implement fetch completed habits by date function
        Gap(12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: const HabitsCompletedDate(),
        ),
      ],
    );
  }
}
