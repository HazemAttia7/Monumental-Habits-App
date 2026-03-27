import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/views/widgets/header_row.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/views/widgets/stats_row.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:provider/provider.dart';

class HabitsHistorySliverListItem extends StatelessWidget {
  final Habit habit;
  const HabitsHistorySliverListItem({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.r),
      child: InkWell(
        onTap: () {
          GoRouter.of(context).push(
            AppRouter.kHabitAnalysis,
            extra: {
              "habit": habit,
              "cubit": context.read<HabitsCubit>(),
              "themeColor": AppColors.secondaryColor,
            },
          );
        },
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(18.r),
        child: Container(
          padding: EdgeInsets.all(18.sp),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18.r)),
          child: Column(
            children: [
              Column(
                children: [
                  HeaderRow(
                    habitName: habit.name,
                    createdAt: habit.createdAt,
                    habitStatus: habit.status,
                  ),
                  Gap(12.h),
                  StatsRow(
                    currentStreak: habit.currentStreak,
                    longestStreak: habit.longestStreak,
                    completionRate: habit.completionRate,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
