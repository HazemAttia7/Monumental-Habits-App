import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_analytics_widget.dart';

class ProfileAnalyticsRow extends StatelessWidget {
  const ProfileAnalyticsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsCubit, HabitsState>(
      buildWhen: (previous, current) => current is HabitsLoaded,
      builder: (context, state) {
        if (state is! HabitsLoaded) return const SizedBox.shrink();

        final habits = state.habits;
        final completedHabits = state.completedHabits.length;
        final longestStreak = habits.isEmpty
            ? 0
            : habits
                  .map((h) => h.longestStreak)
                  .reduce((a, b) => a > b ? a : b);

        return Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.scaffoldColor),
                  top: BorderSide(color: AppColors.scaffoldColor),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ProfileAnalyticsWidget(
                      title: "Longest Streak (Days)",
                      subtitle: longestStreak.toString(),
                      icon: FontAwesomeIcons.fireFlameCurved,
                      iconColor: AppColors.primaryColor,
                    ),
                  ),
                  Gap(32.w),
                  Expanded(
                    child: ProfileAnalyticsWidget(
                      title: "Habits Completed",
                      subtitle: completedHabits.toString(),
                      icon: FontAwesomeIcons.flagCheckered,
                      iconColor: AppColors.twilight,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: VerticalDivider(
                  color: AppColors.scaffoldColor,
                  width: 1.w,
                  thickness: 1.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
