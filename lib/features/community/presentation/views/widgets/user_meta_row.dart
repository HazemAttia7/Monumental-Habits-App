import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';

class UserMetaRow extends StatelessWidget {
  final String userName;
  final Duration postedSince;
  const UserMetaRow({
    super.key,
    required this.userName,
    required this.postedSince,
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
              userName,
              style: AppStyles.textStyle14.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.15,
              ),
            ),
            Text(
              _getTimeAgo(),
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

  String _getTimeAgo() {
    final days = postedSince.inDays;
    final hours = postedSince.inHours;
    final minutes = postedSince.inMinutes;
    final seconds = postedSince.inSeconds;
    if (days > 0) {
      return "${days}d ago";
    } else if (hours > 0) {
      return "${hours}h ago";
    } else if (minutes > 0) {
      return "${minutes}m ago";
    } else {
      return "${seconds}s ago";
    }
  }
}
