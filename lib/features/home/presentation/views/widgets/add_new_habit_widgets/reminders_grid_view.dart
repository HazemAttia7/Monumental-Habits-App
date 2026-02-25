import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_frequency_grid_view_item.dart';

class RemindersGridView extends StatelessWidget {
  final List<bool> selectedReminders;
  final Function(int, bool) onDayChanged;

  const RemindersGridView({
    super.key,
    required this.selectedReminders,
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
        crossAxisCount: 3,
        childAspectRatio: 120 / 92,
      ),
      itemBuilder: (context, index) => OnOffGridViewItem(
        day: initialReminders[index],
        isOn: selectedReminders[index],
        onTap: (value) => onDayChanged(index, value),
      ),
      itemCount: 12,
      shrinkWrap: true,
    );
  }
}
