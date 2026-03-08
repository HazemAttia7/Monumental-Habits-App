import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/add_edit_habit_header.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_frequency_widget.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_name_input.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/notifications_widget.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/reminder_widget.dart';

class AddEditHabitViewBody extends StatelessWidget {
  final VoidCallback? backToHome;
  final enHabitFormMode mode;
  final Color? themeColor;
  const AddEditHabitViewBody({
    super.key,
    required this.backToHome,
    required this.mode,
    this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
          child: Column(
            children: [
              Gap(10.h),
              SizedBox(
                height: 44.sp,
                child: AddEditHabitHeader(
                  backToHome: backToHome,
                  themeColor: themeColor,
                  mode: mode,
                ),
              ),
              Gap(24.h),
              const HabitNameInput(),
              Gap(10.h),
              const HabitFrequencyWidget(),
              Gap(10.h),
              const ReminderWidget(),
              Gap(10.h),
              const NotificationsWidget(),
              Gap(24.h),
              if (mode == enHabitFormMode.edit)
                Column(
                  children: [
                    // TODO : Add segmented button to switch between habit status (complete or missed or in progress)
                    CustomButton(
                      onTap: () {
                        // TODO : Update Habit
                      },
                      text: "Update Habit",
                      backColor: themeColor,
                      textColor:
                          ThemeData.estimateBrightnessForColor(
                                themeColor ?? AppColors.secondaryColor,
                              ) ==
                              Brightness.dark
                          ? Colors.white
                          : AppColors.primaryColor,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
