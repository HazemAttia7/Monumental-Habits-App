import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/managers/cubits/home_cubit/home_cubit.dart';
import 'package:provider/provider.dart';

class HabitAnalysisHeader extends StatelessWidget {
  final Color themeColor;
  final Habit habit;
  const HabitAnalysisHeader({
    super.key,
    required this.themeColor,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          onTap: () {
            GoRouter.of(context).pop();
          },
          icon: FontAwesomeIcons.arrowLeft,
          iconColor: themeColor,
          backColor: themeColor.withValues(alpha: .1),
        ),
        Text("Habit Analysis", style: AppStyles.textStyle18),
        CustomIconButton(
          onTap: () {
            GoRouter.of(context).push(
              AppRouter.kAddNewHabit,
              extra: {
                "mode": enHabitFormMode.edit,
                "backToHome": () => GoRouter.of(context).pop(),
                "themeColor": themeColor,
                "habit": habit,
                "homeCubit": context.read<HomeCubit>(),
              },
            );
          },
          icon: FontAwesomeIcons.pencil,
          iconColor: themeColor,
          backColor: themeColor.withValues(alpha: .1),
        ),
      ],
    );
  }
}
