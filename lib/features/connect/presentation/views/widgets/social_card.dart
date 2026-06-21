import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class SocialCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color themeColor;
  final VoidCallback onTap;
  const SocialCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.themeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        splashColor: themeColor.withValues(alpha: .1),
        highlightColor: themeColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 8.w,
                children: [
                  IconContainer(
                    icon: icon,
                    iconSize: 28.sp,
                    padding: EdgeInsets.all(6.sp),
                    iconColor: themeColor,
                    backColor: themeColor.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  Column(
                    spacing: 4.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppStyles.textStyle16.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Klasik',
                          height: 1,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: AppStyles.textStyle14.copyWith(
                          color: themeColor.withValues(alpha: .5),
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Klasik',
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
