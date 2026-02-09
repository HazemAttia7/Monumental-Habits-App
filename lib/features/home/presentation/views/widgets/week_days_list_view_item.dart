import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/current_day_badge.dart';

class WeekDaysListViewItem extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  const WeekDaysListViewItem({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
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
                  Text(
                    getDay(),
                    style: AppStyles.textStyle10.copyWith(
                      color: AppColors.primaryColor.withValues(alpha: .5),
                    ),
                  ),
                  Text(getDateDay(), style: AppStyles.textStyle16),
                ],
              ),
            ),
          ),
          if (index == DateTime.now().weekday % 7)
            const Positioned(
              left: 0,
              right: 0,
              child: Center(child: CurrentDayBadge()),
            ),
        ],
      ),
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

  // TODO : Solve Week days problem
  String getDateDay() {
    final currentDate = DateTime.now();
    return currentDate
        .subtract(Duration(days: currentDate.weekday % 7 - index))
        .day
        .toString();
  }
}
