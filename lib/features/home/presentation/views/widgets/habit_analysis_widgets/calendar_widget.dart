import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/calender_grid_view_item.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/month_actions.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/week_days_row.dart';

class CalendarWidget extends StatelessWidget {
  final Color themeColor;
  const CalendarWidget({super.key, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: MonthActions(
              onNextTap: () {},
              onBackTap: () {},
              month: 'January',
            ),
          ),
          Gap(16.h),
          const WeekDaysRow(),
          Gap(8.h),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 47 / 82,
              mainAxisSpacing: 8.sp,
              crossAxisSpacing: 6.sp,
            ),
            itemBuilder: (context, index) =>
                CalenderGridViewItem(themeColor: themeColor, number: index + 1),
            itemCount: 35,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
