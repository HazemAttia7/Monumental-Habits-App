import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/on_off_grid_view_item.dart';

class HabitFrequencyGridView extends StatelessWidget {
  final Color? themeColor;
  const HabitFrequencyGridView({super.key, this.themeColor});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddEditHabitController>();

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
        themeColor: themeColor ?? AppColors.secondaryColor,
      ),
      itemCount: 7,
      shrinkWrap: true,
    );
  }
}
