import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class StatCardLabel extends StatelessWidget {
  final String label;
  const StatCardLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      label.toUpperCase(),
      style: AppStyles.textStyle14.copyWith(
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        letterSpacing: 1.2,
      ),
    );
  }
}
