import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/community/helper/get_time_ago.dart';

class UserMetaInfoRow extends StatelessWidget {
  const UserMetaInfoRow({
    super.key,
    required this.userName,
    required this.createdAt,
  });

  final String userName;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePlaceholder(
          fontSize: 18.sp,
          padding: EdgeInsets.all(10.sp),
          userName: userName,
        ),
        Gap(12.h),
        Column(
          children: [
            Text(userName, style: AppStyles.textStyle16),
            Text(_getPostedSince(), style: AppStyles.textStyle12),
          ],
        ),
      ],
    );
  }

  String _getPostedSince() {
    final duration = DateTime.now().difference(createdAt);
    return getTimeAgo(duration);
  }
}
