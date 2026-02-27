import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_divider.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_suggestion_unit.dart';

class HabitSuggestionsBottomSheet extends StatelessWidget {
  HabitSuggestionsBottomSheet({super.key});

  final List<String> habitSuggestions = [
    "Drink 2L of water",
    "Walk 8,000+ steps",
    "Read 20 pages",
    "Practice coding 1 hour",
    "Plan tomorrow",
    "Wake up early",
    "Meditate 10 minutes",
    "Write 3 things you're grateful for",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomDivider(
              color: AppColors.primaryColor.withValues(alpha: 0.5),
              width: 40.w,
              height: 3.sp,
              margin: 0,
              borderRadius: BorderRadius.circular(9999.r),
            ),
            Gap(24.h),
            Text(
              "Habit Suggestions",
              style: AppStyles.textStyle20.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            Gap(24.h),
            ...List.generate(
              habitSuggestions.length,
              (index) => HabitSuggestionUnit(
                text: habitSuggestions[index],
                onTap: () {
                  // TODO : Link with habit name field
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
