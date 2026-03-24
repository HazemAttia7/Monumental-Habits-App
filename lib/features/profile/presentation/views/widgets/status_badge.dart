import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String title;
  final IconData icon;
  const StatusBadge({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.sp),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(9999.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 16.sp),
          Gap(4.w),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              letterSpacing: .55,
              height: 1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
