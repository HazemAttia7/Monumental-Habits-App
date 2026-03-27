import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class StatsRow extends StatelessWidget {
  final int currentStreak, longestStreak;
  final double completionRate;
  const StatsRow({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
    required this.completionRate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStreakText(label: "current", streak: currentStreak),
        Icon(
          Icons.circle,
          color: AppColors.secondaryColor.withValues(alpha: .3),
          size: 6.sp,
        ),
        _buildStreakText(
          label: "best",
          streak: longestStreak,
          textColor: Colors.black,
        ),
        Icon(
          Icons.circle,
          color: AppColors.secondaryColor.withValues(alpha: .3),
          size: 6.sp,
        ),
        Text(
          "${completionRate.toStringAsFixed(0)}% done".toUpperCase(),
          style: AppStyles.textStyle10.copyWith(
            fontFamily: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
            ).fontFamily,
            color: AppColors.secondaryColor.withValues(alpha: .7),
          ),
        ),
      ],
    );
  }

  Text _buildStreakText({
    required String label,
    required int streak,
    Color? textColor,
  }) {
    return Text(
      "$label: ${_getStreakText(streak)}".toUpperCase(),
      style: AppStyles.textStyle10.copyWith(
        fontFamily: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.bold,
        ).fontFamily,
        color: textColor ?? AppColors.secondaryColor.withValues(alpha: .7),
      ),
    );
  }

  String _getStreakText(int streak) {
    if (streak == 1) {
      return "1 DAY";
    } else {
      return "$streak DAYS";
    }
  }
}
