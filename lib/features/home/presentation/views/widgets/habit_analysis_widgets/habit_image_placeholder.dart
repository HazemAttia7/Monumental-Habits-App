import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';

class HabitImagePlaceholder extends StatelessWidget {
  final Color themeColor;
  const HabitImagePlaceholder({super.key, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.sp),
      decoration: BoxDecoration(
        color: themeColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Image.asset(AssetsData.teepeeSwirly, width: 60.w),
    );
  }
}
