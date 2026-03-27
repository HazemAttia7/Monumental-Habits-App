import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/icon_button_with_shadow.dart';
import 'package:pixel_true_app/core/widgets/habit_title_row.dart';
import 'package:provider/provider.dart';

class ItemHeader extends StatelessWidget {
  final Habit habit;
  const ItemHeader({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: HabitTitleRow(
            habitName: habit.name,
            createdAt: habit.createdAt,
          ),
        ),
        IconButtonWithShadow(
          icon: FontAwesomeIcons.ellipsis,
          color: AppColors.secondaryColor,
          iconSize: 20.sp,
          onTap: () {
            GoRouter.of(context).push(
              AppRouter.kHabitAnalysis,
              extra: {"habit": habit, "cubit": context.read<HabitsCubit>()},
            );
          },
        ),
      ],
    );
  }
}
