import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final enHabitStatus status;
  const StatusBadge({super.key, required this.status});

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
          Icon(_getIcon(), color: AppColors.primaryColor, size: 14.sp),
          Gap(4.w),
          Text(
            _getText(),
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
              fontFamily: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
              ).fontFamily,
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

  String _getText() {
    switch (status) {
      case enHabitStatus.completed:
        return 'COMPLETED';
      case enHabitStatus.missed:
        return 'MISSED';
      case enHabitStatus.inProgress:
        return 'IN PROGRESS';
    }
  }

  IconData _getIcon() {
    switch (status) {
      case enHabitStatus.completed:
        return FontAwesomeIcons.check;
      case enHabitStatus.missed:
        return FontAwesomeIcons.xmark;
      case enHabitStatus.inProgress:
        return FontAwesomeIcons.spinner;
    }
  }
}
