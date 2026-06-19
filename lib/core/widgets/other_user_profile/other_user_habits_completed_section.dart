import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/profile_enums.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_performed_habits_count_list.dart';

class OtherUserHabitsCompletedSection extends StatelessWidget {
  final enProfileFilterBy value;
  const OtherUserHabitsCompletedSection({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "HABITS PERFORMED PER ${_getTitle(value)}".toUpperCase(),
          style: AppStyles.textStyle12,
        ),
        Gap(8.h),
        OtherUserPerformedHabitsCountList(filterBy: value),
      ],
    );
  }

  String _getTitle(enProfileFilterBy value) {
    switch (value) {
      case enProfileFilterBy.year:
        return 'MONTH';
      case enProfileFilterBy.month:
        return 'DAY';
      case enProfileFilterBy.week:
        return 'DAY';
    }
  }
}
