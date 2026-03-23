import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class AmPmContainer extends StatelessWidget {
  final String period;
  final bool isSelected;
  final VoidCallback toggle;
  final Color themeColor;
  const AmPmContainer({
    super.key,
    required this.period,
    this.isSelected = false,
    required this.toggle,
    this.themeColor = AppColors.secondaryColor,
  });

  Color get _buttonTextColor =>
      ThemeData.estimateBrightnessForColor(themeColor) == Brightness.dark
      ? Colors.white
      : AppColors.secondaryColor;

  @override
  Widget build(BuildContext context) {
    final Color textColor = isSelected ? _buttonTextColor : themeColor;
    final Color backColor = isSelected ? themeColor : AppColors.scaffoldColor;
    return Material(
      color: backColor,
      child: InkWell(
        splashColor: textColor.withValues(alpha: 0.2),
        highlightColor: textColor.withValues(alpha: 0.2),
        onTap: toggle,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Center(
            child: Text(
              period,
              style: AppStyles.textStyle22.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
