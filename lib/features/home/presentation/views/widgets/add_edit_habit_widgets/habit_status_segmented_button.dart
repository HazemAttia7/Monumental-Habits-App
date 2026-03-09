import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:provider/provider.dart';

class HabitStatusSegmentedButton extends StatelessWidget {
  const HabitStatusSegmentedButton({super.key, required this.themeColor});

  final Color? themeColor;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddEditHabitController>();

    return SegmentedButton<enHabitStatus>(
      showSelectedIcon: false,
      onSelectionChanged: controller.changeStatus,
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          TextStyle(fontFamily: 'Klasik', fontSize: 15.sp),
        ),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return themeColor;
          }
          return themeColor?.withValues(alpha: .1);
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ThemeData.estimateBrightnessForColor(
                      themeColor ?? AppColors.secondaryColor,
                    ) ==
                    Brightness.dark
                ? Colors.white
                : AppColors.primaryColor;
          }
          return themeColor;
        }),
        side: WidgetStateProperty.all(
          BorderSide(color: themeColor ?? AppColors.secondaryColor),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      segments: const [
        ButtonSegment(value: enHabitStatus.completed, label: Text("Complete")),
        ButtonSegment(value: enHabitStatus.missed, label: Text("Missed")),
        ButtonSegment(
          value: enHabitStatus.inProgress,
          label: Text("In Progress"),
        ),
      ],
      selected: {controller.status},
    );
  }
}
