import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_frequency_grid_view_item.dart';

class HabitFrequencyBottomSheet extends StatelessWidget {
  const HabitFrequencyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Center(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 140 / 112,
            mainAxisSpacing: 8.sp,
            crossAxisSpacing: 8.sp,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) => index == 6 || index == 8
              ? const SizedBox.shrink()
              : const HabitFrequencyGridViewItem(),
          itemCount: 9,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
