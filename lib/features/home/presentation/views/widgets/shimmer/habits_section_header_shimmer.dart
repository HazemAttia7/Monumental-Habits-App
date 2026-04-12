import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/shimmer/week_days_list_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class HabitsSectionHeaderShimmer extends StatelessWidget {
  const HabitsSectionHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade100,
            child: Text(
              "HABITS",
              style: AppStyles.textStyle14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(height: 50.h, child: const WeekDaysListShimmer()),
        ),
      ],
    );
  }
}
