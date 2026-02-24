import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_frequency_grid_view_item.dart';

class HabitFrequencyGridView extends StatelessWidget {
  final List<bool> selectedDays;
  final Function(int, bool) onDayChanged;

  const HabitFrequencyGridView({
    super.key,
    required this.selectedDays,
    required this.onDayChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.sp,
        crossAxisSpacing: 8.sp,
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) => HabitFrequencyGridViewItem(
        day: index == 7 ? 'Sat' : weekDaysShort[index],
        isOn: selectedDays[index],
        onTap: (value) => onDayChanged(index, value),
      ),
      itemCount: 7,
      shrinkWrap: true,
    );
  }
}
