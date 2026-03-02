import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class AmPmContainer extends StatelessWidget {
  final String period;
  final Color textColor, backColor;
  const AmPmContainer({
    super.key,
    required this.period,
    required this.textColor,
    required this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      color: backColor,
      child: Center(
        child: Text(
          period,
          style: AppStyles.textStyle22.copyWith(color: textColor),
        ),
      ),
    );
  }
}
