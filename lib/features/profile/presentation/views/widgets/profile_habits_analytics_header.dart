import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';

class ProfileHabitsAnalyticsHeader extends StatelessWidget {
  const ProfileHabitsAnalyticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          onTap: () => Navigator.pop(context),
          iconColor: AppColors.secondaryColor,
          backColor: AppColors.secondaryColor.withValues(alpha: .1),
          icon: FontAwesomeIcons.arrowLeft,
        ),
        Gap(16.w),
        Text("Habits Analytics", style: AppStyles.textStyle20),
      ],
    );
  }
}
