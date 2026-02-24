import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/custom_switcher.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_frequency_grid_view.dart';

class HabitFrequencyBottomSheet extends StatefulWidget {
  const HabitFrequencyBottomSheet({super.key});

  @override
  State<HabitFrequencyBottomSheet> createState() =>
      _HabitFrequencyBottomSheetState();
}

class _HabitFrequencyBottomSheetState extends State<HabitFrequencyBottomSheet> {
  bool _isEverydaySwitched = false, _isWeekendsSwitched = false;

  List<bool> selectedDays = List.generate(7, (_) => false);

  void toggleEveryday(bool value) {
    setState(() {
      _isEverydaySwitched = value;
      _isWeekendsSwitched = value;
      selectedDays = List.generate(7, (_) => value);
    });
  }

  void toggleWeekends(bool value) {
    setState(() {
      _isWeekendsSwitched = value;
      selectedDays[5] = value;
      selectedDays[6] = value;
    });
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSwitcher(
                  isSwitched: _isEverydaySwitched,
                  onChanged: toggleEveryday,
                  text: "Everyday",
                ),
                CustomSwitcher(
                  isSwitched: _isWeekendsSwitched,
                  onChanged: toggleWeekends,
                  text: 'Weekends',
                ),
              ],
            ),
            Gap(15.h),
            HabitFrequencyGridView(
              selectedDays: selectedDays,
              onDayChanged: (index, value) {
                setState(() {
                  selectedDays[index] = value;
                  if (!value) {
                    _isEverydaySwitched = false;
                  }
                  if (selectedDays.every((e) => e)) {
                    _isEverydaySwitched = true;
                  }
                  _isWeekendsSwitched = selectedDays[5] && selectedDays[6];
                });
              },
            ),
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
