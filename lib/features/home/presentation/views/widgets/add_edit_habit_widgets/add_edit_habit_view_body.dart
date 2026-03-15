import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/managers/cubits/home_cubit/home_cubit.dart';
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
              const HabitNameInput(),
              Gap(10.h),
              // TODO : make it use themeColor
              const HabitFrequencyWidget(),
              Gap(10.h),
              // TODO : make it use themeColor
              const ReminderWidget(),
              Gap(10.h),
              // TODO : make it use themeColor
              const NotificationsWidget(),
              Gap(24.h),
              if (mode == enHabitFormMode.edit)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HabitStatusSegmentedButton(themeColor: themeColor),
                    Gap(12.h),
                    CustomButton(
                      onTap: () {
                        final updatedHabit = context
                            .read<AddEditHabitController>()
                            .buildUpdatedHabit();
                        context.read<HomeCubit>().updateHabit(updatedHabit);
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
