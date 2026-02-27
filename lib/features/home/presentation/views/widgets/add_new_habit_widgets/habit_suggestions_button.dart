import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_suggestion_bottom_sheet.dart';

class HabitSuggestionsButton extends StatelessWidget {
  const HabitSuggestionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          elevation: 10,
          context: context,
          builder: (_) => Wrap(children: [HabitSuggestionsBottomSheet()]),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Ink(
            padding: EdgeInsets.all(7.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child: Icon(
              FontAwesomeIcons.bookOpenReader,
              color: AppColors.primaryColor,
              size: 35.w,
            ),
          ),
          Positioned(
            top: -5.sp,
            right: -5.sp,
            child: Icon(
              FontAwesomeIcons.circlePlus,
              color: AppColors.morning,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
