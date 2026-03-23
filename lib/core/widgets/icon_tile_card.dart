import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class IconTileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const IconTileCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(
            children: [
              IconContainer(
                icon: icon,
                iconColor: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12.r),
                padding: EdgeInsets.all(10.sp),
              ),
              Gap(14.h),
              Text(
                title,
                style: AppStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 18.sp,
                  shadows: [
                    Shadow(
                      color: AppColors.secondaryColor.withValues(alpha: .5),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
