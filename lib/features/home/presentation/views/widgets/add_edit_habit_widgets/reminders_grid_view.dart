import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/removable_on_off_grid_view_item.dart';

class RemindersGridView extends StatelessWidget {
  final Color? themeColor;
  const RemindersGridView({super.key, this.themeColor});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddEditHabitController>();

    return controller.remindersTime.isEmpty
        ? SizedBox(
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                'No reminders yet.\nTap "Add Reminder" to stay on track.',
                style: AppStyles.textStyle16,
              ),
            ),
          )
        : GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8.sp,
              crossAxisSpacing: 8.sp,
              crossAxisCount: 3,
              childAspectRatio: 120 / 92,
            ),
            itemBuilder: (context, index) => RemovableOnOffGridViewItem(
              themeColor: themeColor ?? AppColors.secondaryColor,
              unit: controller.remindersTime[index],
              isOn: controller.remindersList[index],
              onTap: (value) => controller.onReminderChanged(index, value),
            ),
            itemCount: controller.remindersTime.length,
            shrinkWrap: true,
          );
  }
}
