import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/rounded_bottom_left_triangle.dart';

class HabitCompletionListViewItem extends StatelessWidget {
  final Color themeColor;
  final enHabitDailyStatus habitCompletionState;
  final bool isActive;
  final VoidCallback onTap;
  const HabitCompletionListViewItem({
    super.key,
    required this.themeColor,
    required this.onTap,
    this.isActive = true,
    this.habitCompletionState = enHabitDailyStatus.none,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !isActive,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 50.sp,
              height: 50.sp,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: habitCompletionState == enHabitDailyStatus.none
                    ? themeColor.withValues(alpha: .1)
                    : themeColor.withValues(alpha: .15),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _buildShape(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShape() {
    switch (habitCompletionState) {
      case enHabitDailyStatus.partial:
        return RoundedBottomLeftTriangle(
          key: const ValueKey('partial'),
          color: themeColor,
        );

      case enHabitDailyStatus.complete:
        return Container(
          key: const ValueKey('complete'),
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
        );

      case enHabitDailyStatus.none:
        return const SizedBox.shrink(key: ValueKey('none'));
    }
  }
}
