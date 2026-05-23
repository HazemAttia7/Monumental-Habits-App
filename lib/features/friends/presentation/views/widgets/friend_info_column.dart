import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';

class FriendInfoColumn extends StatelessWidget {
  final String username;
  const FriendInfoColumn({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfilePlaceholder(
              username: username,
              fontSize: 12.sp,
              padding: EdgeInsets.all(8.sp),
            ),
          ],
        ),
        Gap(4.w),
        Text(
          username,
          style: AppStyles.textStyle14.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
