import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/profile_enums.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/month_performed_habits_count_list.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/week_performed_habits_count_list.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/year_performed_habits_count_list.dart';

class PerformedHabitsCountList extends StatelessWidget {
  final enProfileFilterBy filterBy;
  const PerformedHabitsCountList({super.key, required this.filterBy});

  @override
  Widget build(BuildContext context) {
    switch (filterBy) {
      case enProfileFilterBy.year:
        return const YearPerformedHabitsCountList();
      case enProfileFilterBy.month:
        return const MonthPerformedHabitsCountList();
      case enProfileFilterBy.week:
        return const WeekPerformedHabitsCountList();
    }
  }
}
