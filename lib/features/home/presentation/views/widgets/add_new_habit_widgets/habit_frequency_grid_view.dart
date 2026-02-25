import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_new_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_frequency_grid_view_item.dart';

class HabitFrequencyGridView extends StatelessWidget {
  const HabitFrequencyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddNewHabitController>();

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.sp,
        crossAxisSpacing: 8.sp,
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) => OnOffGridViewItem(
        day: index == 7 ? 'Sat' : weekDaysShort[index],
        isOn: controller.habitFrequencyList[index],
        onTap: (value) => controller.onDayChanged(index, value),
      ),
      itemCount: 7,
      shrinkWrap: true,
    );
  }
}
