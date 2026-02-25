import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/monumental_habits_icons.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/reminders_grid_view.dart';

class ReminderBottomSheet extends StatefulWidget {
  const ReminderBottomSheet({super.key});

  @override
  State<ReminderBottomSheet> createState() => _ReminderBottomSheetState();
}

class _ReminderBottomSheetState extends State<ReminderBottomSheet> {
  List<bool> selectedReminders = List.generate(12, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            RemindersGridView(
              selectedReminders: selectedReminders,
              onDayChanged: (index, value) {
                setState(() {
                  selectedReminders[index] = value;
                });
              },
            ),
            Gap(25.h),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: CustomButton(
                    text: "Add Reminder",
                    onTap: () {
                      // TODO : Show reminder time picker
                      // TODO : Add Reminder logic
                      Navigator.pop(context);
                    },
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () {
                        setState(() {
                          selectedReminders = List.generate(12, (_) => false);
                        });
                      },
                      child: Container(
                        height: 60.h,
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            width: 3.sp,
                            color: AppColors.primaryColor.withValues(alpha: .3),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            MonumentalHabitsIcons.mute_notifications,
                            color: AppColors.primaryColor.withValues(alpha: .3),
                            size: 26.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
