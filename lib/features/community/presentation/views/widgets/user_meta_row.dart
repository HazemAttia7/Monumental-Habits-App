import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/community/helper/get_time_ago.dart';

class UserMetaRow extends StatelessWidget {
  final String userName;
  final String? displayName;
  final Duration? postedSince;
  const UserMetaRow({
    super.key,
    required this.userName,
    this.postedSince,
    this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePlaceholder(
          width: 34.w,
          height: 34.h,
          fontSize: 14.sp,
          padding: EdgeInsets.all(2.sp),
          userName: userName,
        ),
        Gap(10.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayName ?? userName,
              style: AppStyles.textStyle14.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.15,
              ),
            ),
            if (postedSince != null)
              Text(
                getTimeAgo(postedSince!),
                style: AppStyles.textStyle12.copyWith(
                  color: AppColors.secondaryColor.withValues(alpha: .5),
                  height: 1.15,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
