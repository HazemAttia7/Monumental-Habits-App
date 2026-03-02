import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/add_reminder_header.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/am_pm_toggle.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/time_scroll_view.dart';

class AddReminderBottomSheet extends StatelessWidget {
  const AddReminderBottomSheet({super.key});

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
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddReminderHeader(),
            Expanded(child: TimeScrollView()),
            AmPmToggle(),
          ],
        ),
      ),
    );
  }
}
