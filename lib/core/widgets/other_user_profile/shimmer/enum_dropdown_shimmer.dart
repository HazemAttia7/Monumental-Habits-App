import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:shimmer/shimmer.dart';

class EnumDropdownShimmer extends StatelessWidget {
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const EnumDropdownShimmer({
    super.key,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: padding ?? EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: .1),
          borderRadius: borderRadius ?? BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("This week", style: AppStyles.textStyle14),
            Gap(12.w),
            Icon(FontAwesomeIcons.angleDown, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
