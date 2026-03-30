import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/monumental_habits_icons.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_handler.dart';
import 'package:pixel_true_app/core/managers/add_edit_habit_view_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/add_reminder_bottom_sheet.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/reminders_grid_view.dart';
import 'package:provider/provider.dart';

class ReminderBottomSheet extends StatelessWidget {
  final Color? themeColor;
  const ReminderBottomSheet({super.key, this.themeColor});
  Color get _buttonTextColor =>
      ThemeData.estimateBrightnessForColor(
            themeColor ?? AppColors.primaryColor,
          ) ==
          Brightness.dark
      ? Colors.white
      : AppColors.secondaryColor;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AddEditHabitViewController>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.9,
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        children: [
          const CustomHandler(),
          Text(
            "Long Press to Delete",
            style: AppStyles.textStyle14.copyWith(
              color: AppColors.sunset.withValues(alpha: .5),
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(12.h),
          Expanded(
            child: SingleChildScrollView(
              child: RemindersGridView(themeColor: themeColor),
            ),
          ),
          Gap(25.h),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: CustomButton(
                  text: "Add Reminder",
                  backColor: themeColor ?? AppColors.primaryColor,
                  textColor: _buttonTextColor,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => ChangeNotifierProvider.value(
                        value: controller,
                        child: AddReminderBottomSheet(themeColor: themeColor),
                      ),
                    );
                  },
                ),
              ),
              Gap(12.w),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: controller.clearReminders,
                    child: Container(
                      height: 60.h,
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          width: 3.sp,
                          color: AppColors.secondaryColor.withValues(alpha: .3),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          MonumentalHabitsIcons.mute_notifications,
                          color: AppColors.secondaryColor.withValues(alpha: .3),
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
    );
  }
}
