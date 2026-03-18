import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/icon_button_with_shadow.dart';

class ProfileHabitsAnalytics extends StatelessWidget {
  const ProfileHabitsAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          IconContainer(
            icon: FontAwesomeIcons.medal,
            iconColor: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12.r),
            padding: EdgeInsets.all(10.sp),
          ),
          Gap(14.h),
          Text(
            "Habits Analytics",
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: IconButtonWithShadow(
              icon: FontAwesomeIcons.chevronRight,
              color: AppColors.primaryColor,
              onTap: () {
                // TODO : Show all habits analytics (use paging)
              },
            ),
          ),
        ],
      ),
    );
  }
}
