import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_frequency_day_item.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/text_icon_widget.dart';

class HabitFrequencyWidget extends StatelessWidget {
  const HabitFrequencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 17.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Habit Frequency",
                  style: AppStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const TextIconWidget(),
              ],
            ),
          ),
          Gap(17.h),
          Divider(thickness: 1.sp, color: const Color(0xffFFF3E9), height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) => HabitFrequencyDayItem(showBorder: index != 6),
            ),
          ),
        ],
      ),
    );
  }
}
