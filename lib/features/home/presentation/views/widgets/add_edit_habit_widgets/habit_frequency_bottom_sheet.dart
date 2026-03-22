import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/custom_switcher.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/habit_frequency_grid_view.dart';

class HabitFrequencyBottomSheet extends StatefulWidget {
  final Color? themeColor;
  const HabitFrequencyBottomSheet({super.key, this.themeColor});

  @override
  State<HabitFrequencyBottomSheet> createState() =>
      _HabitFrequencyBottomSheetState();
}

class _HabitFrequencyBottomSheetState extends State<HabitFrequencyBottomSheet> {
  Color get _buttonTextColor =>
      ThemeData.estimateBrightnessForColor(
            widget.themeColor ?? AppColors.secondaryColor,
          ) ==
          Brightness.dark
      ? Colors.white
      : AppColors.primaryColor;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddEditHabitController>();

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSwitcher(
                  themeColor: widget.themeColor,
                  isSwitched: controller.isEverydaySwitched,
                  onChanged: controller.toggleEveryday,
                  text: "Everyday",
                ),
                CustomSwitcher(
                  themeColor: widget.themeColor,
                  isSwitched: controller.isWeekendsSwitched,
                  onChanged: controller.toggleWeekends,
                  text: 'Weekends',
                ),
              ],
            ),
            Gap(15.h),
            HabitFrequencyGridView(themeColor: widget.themeColor),
            Gap(25.h),
            CustomButton(
              text: "Save",
              onTap: () {
                GoRouter.of(context).pop();
              },
              backColor: widget.themeColor ?? AppColors.secondaryColor,
              textColor: _buttonTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
