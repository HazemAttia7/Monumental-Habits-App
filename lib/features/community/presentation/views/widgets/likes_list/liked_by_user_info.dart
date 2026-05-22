import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';

class LikeByUserInfo extends StatelessWidget {
  final String userName;
  final bool isCurrentUser;
  const LikeByUserInfo({
    super.key,
    required this.userName,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePlaceholder(
          username: userName,
          backColor: isCurrentUser ? AppColors.primaryColor : null,
        ),
        Gap(12.w),

        Text(
          userName,
          style: AppStyles.textStyle16.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
