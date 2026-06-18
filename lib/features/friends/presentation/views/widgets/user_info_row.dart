import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';

class UserInfoRow extends StatelessWidget {
  final String username;
  const UserInfoRow({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePlaceholder(username: username),
        Gap(12.w),
        Flexible(
          child: Text(
            username,
            style: AppStyles.textStyle16.copyWith(color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
