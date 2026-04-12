import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:shimmer/shimmer.dart';

class WeekDaysListItemShimmer extends StatelessWidget {
  final int index;
  const WeekDaysListItemShimmer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 50.sp,
          height: 50.sp,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade100,
                  child: Text(
                    getDay(),
                    style: AppStyles.textStyle10.copyWith(
                      color: AppColors.secondaryColor.withValues(alpha: .5),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade100,
                  child: Text(getDateDay(), style: AppStyles.textStyle16),
                ),
              ],
            ),
          ),
        ),
        if (index == DateTime.now().weekday % 7)
          Positioned(
            left: 0,
            right: 0,
            child: Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 3.h,
                  width: 16.sp,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(1000.r),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        color: Colors.grey.withValues(alpha: .5),
                        spreadRadius: 0,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String getDay() {
    switch (index) {
      case 0:
        return "SUN";
      case 1:
        return "MON";
      case 2:
        return "TUE";
      case 3:
        return "WED";
      case 4:
        return "THU";
      case 5:
        return "FRI";
      case 6:
        return "SAT";
      default:
        return "SUN";
    }
  }

  String getDateDay() {
    final currentDate = DateTime.now();
    return currentDate
        .subtract(Duration(days: currentDate.weekday % 7 - index))
        .day
        .toString();
  }
}
