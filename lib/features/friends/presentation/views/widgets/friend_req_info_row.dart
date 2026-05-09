import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';

class FriendReqInfoRow extends StatelessWidget {
  const FriendReqInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ProfilePlaceholder(userName: 'Hazem'),
        Gap(12.w),
        Text(
          "Hazem",
          style: AppStyles.textStyle16.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
