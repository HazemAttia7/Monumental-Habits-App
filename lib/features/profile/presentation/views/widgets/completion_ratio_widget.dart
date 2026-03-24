import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class CompletionRatioWidget extends StatelessWidget {
  final double ratio;
  const CompletionRatioWidget({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 13.sp,
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          height: 1,
        ),
        children: [
          const TextSpan(
            text: "RATIO: ",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: "${ratio.toStringAsFixed(1)} %",
            style: const TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
