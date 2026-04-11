import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';

class DefaultViewHeader extends StatelessWidget {
  final String title;
  final Color? themeColor;
  const DefaultViewHeader({super.key, required this.title, this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          onTap: () => Navigator.pop(context),
          iconColor: themeColor ?? AppColors.secondaryColor,
          backColor:
              themeColor?.withValues(alpha: .1) ??
              AppColors.secondaryColor.withValues(alpha: .1),
          icon: FontAwesomeIcons.arrowLeft,
        ),
        Gap(16.w),
        Expanded(
          child: Text(
            title,
            style: AppStyles.textStyle20,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Gap(28.w),
      ],
    );
  }
}
