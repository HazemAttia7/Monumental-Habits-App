import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_completion_list_view_item.dart';

class HabitCompletionListView extends StatelessWidget {
  final ScrollController scrollController;
  final Color color;
  const HabitCompletionListView({
    super.key,
    required this.scrollController,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.sp,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(right: 6.sp),
          child: HabitCompletionListViewItem(
            // isActive: User.habitFrequencyList[index] --> this list will be returned from Firebase after adding the habit,
            themeColor: color,
            habitName: 'Read A Book',
          ),
        ),
      ),
    );
  }
}
