import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_completion_list_view.dart';

class HabitTrackingWidget extends StatelessWidget {
  final ScrollController scrollController;
  final String text;
  final Color color;
  const HabitTrackingWidget({super.key, required this.scrollController, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18.sp, top: 12.sp, bottom: 12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: AppStyles.textStyle14.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: HabitCompletionListView(scrollController: scrollController , color: color),
          ),
        ],
      ),
    );
  }
}
