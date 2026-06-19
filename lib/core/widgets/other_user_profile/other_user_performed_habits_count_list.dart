import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/profile_enums.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_month_performed_habits_count_list.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_week_performed_habits_count_list.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_year_performed_habits_count_list.dart';

class OtherUserPerformedHabitsCountList extends StatelessWidget {
  final enProfileFilterBy filterBy;
  const OtherUserPerformedHabitsCountList({super.key, required this.filterBy});

  @override
  Widget build(BuildContext context) {
    switch (filterBy) {
      case enProfileFilterBy.year:
        return const OtherUserYearPerformedHabitsCountList();
      case enProfileFilterBy.month:
        return const OtherUserMonthPerformedHabitsCountList();
      case enProfileFilterBy.week:
        return const OtherUserWeekPerformedHabitsCountList();
    }
  }
}
