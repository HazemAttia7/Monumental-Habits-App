import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_new_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/custom_switcher.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_frequency_grid_view.dart';

class HabitFrequencyBottomSheet extends StatefulWidget {
  const HabitFrequencyBottomSheet({super.key});

  @override
  State<HabitFrequencyBottomSheet> createState() =>
      _HabitFrequencyBottomSheetState();
}

class _HabitFrequencyBottomSheetState extends State<HabitFrequencyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddNewHabitController>();

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
                  isSwitched: controller.isEverydaySwitched,
                  onChanged: controller.toggleEveryday,
                  text: "Everyday",
                ),
                CustomSwitcher(
                  isSwitched: controller.isWeekendsSwitched,
                  onChanged: controller.toggleWeekends,
                  text: 'Weekends',
                ),
              ],
            ),
            Gap(15.h),
            const HabitFrequencyGridView(),
            Gap(25.h),
            CustomButton(
              text: "Save",
              onTap: () {
                // TODO : Save frequency logic
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
