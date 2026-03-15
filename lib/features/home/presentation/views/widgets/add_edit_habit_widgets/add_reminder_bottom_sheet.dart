import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/add_edit_reminder_header.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/am_pm_toggle.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/time_scroll_view.dart';

class AddReminderBottomSheet extends StatelessWidget {
  final Color? themeColor;
  const AddReminderBottomSheet({super.key, this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddEditReminderHeader(themeColor: themeColor),
            Expanded(
              child: TimeScrollView(
                themeColor: themeColor ?? AppColors.secondaryColor,
              ),
            ),
            AmPmToggle(themeColor: themeColor ?? AppColors.secondaryColor),
          ],
        ),
      ),
    );
  }
}
