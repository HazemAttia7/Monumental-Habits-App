import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/habit_title_row.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class HeaderRow extends StatelessWidget {
  final String habitName;
  final DateTime createdAt;
  final enHabitStatus habitStatus;
  const HeaderRow({
    super.key,
    required this.habitName,
    required this.createdAt,
    required this.habitStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: HabitTitleRow(
            habitName: habitName,
            createdAt: createdAt,
            themeColor: AppColors.secondaryColor,
            titleColor: Colors.black,
            subtitleColor: Colors.black,
          ),
        ),
        IconContainer(
          icon: _getStatusIcon(habitStatus),
          iconColor: Colors.white,
          backColor: AppColors.secondaryColor,
          padding: EdgeInsets.all(14.sp),
          iconSize: 24.sp,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: AppColors.secondaryColor.withValues(alpha: .2),
              spreadRadius: -3,
              blurRadius: 15,
            ),
            BoxShadow(
              offset: const Offset(0, 2),
              color: AppColors.secondaryColor.withValues(alpha: .2),
              spreadRadius: -4,
              blurRadius: 6,
            ),
          ],
        ),
      ],
    );
  }

  IconData _getStatusIcon(enHabitStatus status) {
    switch (status) {
      case enHabitStatus.inProgress:
        return FontAwesomeIcons.spinner;
      case enHabitStatus.completed:
        return Icons.done_all;
      case enHabitStatus.missed:
        return Icons.close;
    }
  }
}
