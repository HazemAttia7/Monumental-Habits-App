import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class SideMenuListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const SideMenuListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.scaffoldColor2,
        boxShadow: const [
          BoxShadow(
            offset: Offset(6, 6),
            color: Color(0xffE8DECB),
            spreadRadius: 0,
            blurRadius: 12,
          ),
          BoxShadow(
            offset: Offset(-6, -6),
            color: Colors.white,
            spreadRadius: 0,
            blurRadius: 12,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              children: [
                Icon(icon, size: 20.sp, color: AppColors.primaryColor),
                Gap(16.w),
                Text(title, style: AppStyles.textStyle17),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
