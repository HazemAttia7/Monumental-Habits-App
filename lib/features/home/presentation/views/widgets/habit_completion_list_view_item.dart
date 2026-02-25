import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/rounded_bottom_left_triangle.dart';

class HabitCompletionListViewItem extends StatelessWidget {
  final String habitName;
  final Color themeColor;
  final bool isCompleted, isPartiallyCompleted, isDoneOnce;
  const HabitCompletionListViewItem({
    super.key,
    this.isCompleted = false,
    this.isPartiallyCompleted = false,
    this.isDoneOnce = false,
    required this.themeColor,
    required this.habitName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* TODO :
        if -> the i-th day is -->|not|<-- a day in the frequency list of the habit :
          transparent color non-clickable widget
        if -> the i-th day is a day in the frequency list of the habit :
          initial state is not done (light secondary color)

        User taps it:
        Tap 1 → Partial
        Tap 2 → Complete
        Tap 3 → None
        */
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 50.sp,
          height: 50.sp,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: (isDoneOnce || isPartiallyCompleted || isCompleted)
                ? themeColor.withValues(alpha: .1)
                : null,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: (isPartiallyCompleted)
                ? RoundedBottomLeftTriangle(color: themeColor)
                : (isCompleted)
                ? Container(
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
