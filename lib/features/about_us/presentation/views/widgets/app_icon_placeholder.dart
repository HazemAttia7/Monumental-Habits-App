import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';

class AppIconPlaceholder extends StatelessWidget {
  const AppIconPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 70.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: const DecorationImage(
          image: AssetImage(AssetsData.appIcon),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
