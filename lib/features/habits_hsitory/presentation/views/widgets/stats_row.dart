import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/circle_divider.dart';

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
        _StreakText(label: "current", streak: currentStreak),
        const CircleDivider(),
        _StreakText(
          label: "best",
          streak: longestStreak,
          textColor: AppColors.secondaryColor,
        ),
        const CircleDivider(),
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
}

class _StreakText extends StatelessWidget {
  final String label;
  final int streak;
  final Color? textColor;
  const _StreakText({
    required this.label,
    required this.streak,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
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
