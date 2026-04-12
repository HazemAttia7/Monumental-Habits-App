import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/shimmer/week_days_list_item_shimmer.dart';

class WeekDaysListShimmer extends StatelessWidget {
  const WeekDaysListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(right: 6.w),
        child: WeekDaysListItemShimmer(index: index),
      ),
    );
  }
}
