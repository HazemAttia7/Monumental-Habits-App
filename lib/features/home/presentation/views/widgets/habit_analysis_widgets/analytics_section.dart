import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/managers/cubits/home_cubit/home_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/analytics_details.dart';

class AnalyticsSection extends StatelessWidget {
  final Habit habit;
  final Color themeColor;
  const AnalyticsSection({
    super.key,
    required this.themeColor,
    required this.habit,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Color.lerp(themeColor, Colors.white, 0.9),
        boxShadow: [
          BoxShadow(
            color: Color.lerp(themeColor, Colors.white, 0.75)!,
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, -15),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Analytics",
            style: AppStyles.textStyle16.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor.withValues(alpha: .6),
            ),
          ),
          Gap(22.h),
          BlocSelector<HomeCubit, HomeState, Habit?>(
            selector: (state) => state is HabitsLoaded
                ? state.habits.firstWhere((h) => h.id == habit.id)
                : null,
            builder: (context, currentHabit) {
              final h = currentHabit ?? habit;

              return AnalyticsDetails(
                longestStreak: h.longestStreak,
                currentStreak: h.currentStreak,
                easeinessScore: h.easinessScore,
                completionRate: h.completionRate,
              );
            },
          ),
          Gap(24.h),
          CustomButton(
            onTap: () {
              // TODO : Mark habit as complete
            },
            text: "Mark Habit as Complete",
            backColor: themeColor,
            textColor:
                ThemeData.estimateBrightnessForColor(themeColor) ==
                    Brightness.dark
                ? Colors.white
                : AppColors.primaryColor,
          ),
          Gap(10.h),
          CustomButton(
            onTap: () {
              // TODO : Mark habit as missed
            },
            text: "Mark Habit as Missed",
            backColor: Colors.white,
            splashColor: themeColor,
            highlightColor: themeColor,
          ),
          Gap(26.h),
        ],
      ),
    );
  }
}
