import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_text_widget.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';

class SummaryColumn extends StatelessWidget {
  final Habit habit;

  final Color themeColor;
  const SummaryColumn({
    super.key,
    required this.habit,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(habit.name, style: AppStyles.textStyle16),
        Gap(5.h),
        IconTextWidget(
          icon: FontAwesomeIcons.bell,
          text: _getFrequencyText(habit.frequency),
          themeColor: themeColor,
        ),
        Gap(3.h),
        IconTextWidget(
          icon: FontAwesomeIcons.repeat,
          text: _getRemindersText(habit.reminders),
          themeColor: themeColor,
        ),
      ],
    );
  }

  String _getFrequencyText(List<int> frequency) {
    if (frequency.length == 1) {
      return '${frequency[0]} day a week';
    }

    if (frequency.length == 7) {
      return 'Repeat everyday';
    }
    return '${frequency[0]} - ${frequency[1]}  days a week';
  }

  String _getRemindersText(List<String> reminders) {
    if (reminders.isEmpty) {
      return 'No reminders';
    }
    return "Reminders: ${reminders.join(', ')}";
  }
}
