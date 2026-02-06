import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/week_days_list_view.dart';

class HabitsSectionHeader extends StatelessWidget {
  final void Function(int index) onDayTap;
  final ScrollController weekDaysController;
  const HabitsSectionHeader({super.key, required this.onDayTap, required this.weekDaysController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Habits".toUpperCase(),
            style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 50.sp,
            child: WeekDaysListView(onDayTap: onDayTap , scrollController: weekDaysController),
          ),
        ),
      ],
    );
  }
}
