import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/enums/habits_history_enums.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:provider/provider.dart';

class HabitsHistoryController extends ChangeNotifier {
  enFilterHabitsByStatus _status = enFilterHabitsByStatus.all;
  enFilterHabitsByStatus get status => _status;

  void onStatusChanged(enFilterHabitsByStatus status) {
    _status = status;
    notifyListeners();
  }

  void onHabitTapped(BuildContext context, Habit habit) {
    GoRouter.of(context).push(
      AppRouter.kHabitAnalysis,
      extra: {
        "habit": habit,
        "cubit": context.read<HabitsCubit>(),
        "themeColor": AppColors.secondaryColor,
      },
    );
  }
}
