import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/billing_methods.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_summary.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          children: [
            Gap(10.h),
            const ProfileHeader(),
            Gap(32.h),
            const ProfileSummary(),
            Gap(8.h),
            const BillingMethods(),
            Gap(8.h),
          ],
        ),
      ),
    );
  }
}
