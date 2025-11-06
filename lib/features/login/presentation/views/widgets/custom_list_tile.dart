import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CustomListTile extends StatelessWidget {
  final String leadingImage;
  final String title;
  const CustomListTile({
    super.key,
    required this.leadingImage,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 63.w),
      child: Row(
        children: [
          Image.asset(leadingImage, width: 23.sp),
          Gap(29.w),
          Text(title, style: AppStyles.textStyle16),
        ],
      ),
    );
  }
}
