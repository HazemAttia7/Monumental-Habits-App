import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';

class ReqActions extends StatelessWidget {
  const ReqActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          iconColor: AppColors.primaryColor,
          backColor: AppColors.primaryColor.withValues(alpha: .1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.r),
          icon: FontAwesomeIcons.xmark,
          onTap: () {
            // TODO : implement decline request
          },
        ),
        Gap(8.w),
        CustomIconButton(
          iconColor: Colors.white,
          backColor: AppColors.primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.r),
          icon: FontAwesomeIcons.check,
          onTap: () {
            // TODO : implement accept request
          },
        ),
      ],
    );
  }
}
