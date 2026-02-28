import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/habit_comletion_state_enum.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/rounded_bottom_left_triangle.dart';

class HabitCompletionListViewItem extends StatefulWidget {
  final String habitName;
  final Color themeColor;
  final enHabitCompletionState habitCompletionState;
  final bool isActive;

  const HabitCompletionListViewItem({
    super.key,
    this.isActive = true,
    required this.themeColor,
    required this.habitName,
    this.habitCompletionState = enHabitCompletionState.none,
  });

  @override
  State<HabitCompletionListViewItem> createState() =>
      _HabitCompletionListViewItemState();
}

class _HabitCompletionListViewItemState
    extends State<HabitCompletionListViewItem> {
  late enHabitCompletionState _habitCompletionState;

  @override
  void initState() {
    super.initState();
    _habitCompletionState = widget.habitCompletionState;
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !widget.isActive,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            setState(() {
              _habitCompletionState = _habitCompletionState.next();
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 50.sp,
              height: 50.sp,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: _habitCompletionState == enHabitCompletionState.none
                    ? widget.themeColor.withValues(alpha: .05)
                    : widget.themeColor.withValues(alpha: .15),
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
    switch (_habitCompletionState) {
      case enHabitCompletionState.partial:
        return RoundedBottomLeftTriangle(
          key: const ValueKey('partial'),
          color: widget.themeColor,
        );

      case enHabitCompletionState.complete:
        return Container(
          key: const ValueKey('complete'),
          decoration: BoxDecoration(
            color: widget.themeColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
        );

      case enHabitCompletionState.none:
        return const SizedBox.shrink(key: ValueKey('none'));
    }
  }
}
