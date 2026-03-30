import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/add_edit_habit_header.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/habit_frequency_widget.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/habit_name_input.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/habit_status_segmented_button.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/notifications_widget.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/reminder_widget.dart';
import 'package:provider/provider.dart';

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
              HabitNameInput(themeColor: themeColor),
              Gap(10.h),
              HabitFrequencyWidget(themeColor: themeColor),
              Gap(10.h),
              ReminderWidget(themeColor: themeColor),
              Gap(10.h),
              NotificationsWidget(themeColor: themeColor),
              Gap(24.h),
              if (mode == enHabitFormMode.edit)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HabitStatusSegmentedButton(themeColor: themeColor),
                    Gap(12.h),
                    CustomButton(
                      onTap: () {
                        final controller = context
                            .read<AddEditHabitController>();
                        final cubit = context.read<HabitsCubit>();

                        // Get the CURRENT habit from cubit state (has latest logs)
                        final currentHabit = (cubit.state as HabitsLoaded)
                            .habits
                            .firstWhere((h) => h.id == controller.habit!.id);

                        // Build updated habit using current habit as base (preserves logs)
                        final updatedHabit = controller.buildUpdatedHabit(
                          baseHabit: currentHabit,
                        );

                        // Dirty check — only update if something actually changed
                        if (updatedHabit == currentHabit) {
                          GoRouter.of(context).pop();
                          return;
                        }

                        cubit.updateHabit(updatedHabit);
                        buildSuccessSnackBar(
                          context,
                          message: 'Habit updated successfully',
                        );
                        GoRouter.of(context).pop();
                        backToHome?.call();
                      },
                      text: "Update Habit",
                      backColor: themeColor,
                      textColor:
                          ThemeData.estimateBrightnessForColor(
                                themeColor ?? AppColors.primaryColor,
                              ) ==
                              Brightness.dark
                          ? Colors.white
                          : AppColors.secondaryColor,
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
