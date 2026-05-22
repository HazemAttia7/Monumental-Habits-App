import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';

class FriendReqInfoRow extends StatelessWidget {
  final String username;
  const FriendReqInfoRow({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePlaceholder(username: username),
        Gap(12.w),
        Text(
          username,
          style: AppStyles.textStyle16.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
