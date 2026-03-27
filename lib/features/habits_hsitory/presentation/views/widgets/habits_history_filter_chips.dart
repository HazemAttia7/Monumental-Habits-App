import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/habits_history_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class HabitsHistoryFilterChips extends StatelessWidget {
  final enFilterHabitsByStatus status;
  final ValueChanged<enFilterHabitsByStatus> onStatusChanged;

  const HabitsHistoryFilterChips({
    super.key,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _FilterChip(
          label: "All",
          isSelected: status == enFilterHabitsByStatus.all,
          onSelected: () => onStatusChanged(enFilterHabitsByStatus.all),
        ),
        _FilterChip(
          label: "Completed",
          isSelected: status == enFilterHabitsByStatus.completed,
          onSelected: () => onStatusChanged(enFilterHabitsByStatus.completed),
        ),
        _FilterChip(
          label: "In Progress",
          isSelected: status == enFilterHabitsByStatus.inProgress,
          onSelected: () => onStatusChanged(enFilterHabitsByStatus.inProgress),
        ),
        _FilterChip(
          label: "Missed",
          isSelected: status == enFilterHabitsByStatus.missed,
          onSelected: () => onStatusChanged(enFilterHabitsByStatus.missed),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected
                ? AppColors.secondaryColor
                : AppColors.secondaryColor.withValues(alpha: .3),
          ),
        ),
        child: Text(
          label,
          style: AppStyles.textStyle12.copyWith(
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
