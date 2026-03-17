import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_analytics_widget.dart';

class ProfileAnalyticsRow extends StatelessWidget {
  const ProfileAnalyticsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const Expanded(
              child: ProfileAnalyticsWidget(
                title: "Longest Streak (Days)",
                subtitle:
                    "18", //TODO : imlpement get longest streak function in repo
                icon: FontAwesomeIcons.fireFlameCurved,
                iconColor: AppColors.secondaryColor,
              ),
            ),
            Gap(32.w),
            const Expanded(
              child: ProfileAnalyticsWidget(
                title: "Habits Completed",
                subtitle:
                    "12", //TODO : imlpement get completed habits function in repo
                icon: FontAwesomeIcons.flagCheckered,
                iconColor: AppColors.twilight,
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: VerticalDivider(
              color: AppColors.scaffoldColor,
              width: 1.w,
              thickness: 1.sp,
            ),
          ),
        ),
      ],
    );
  }
}
