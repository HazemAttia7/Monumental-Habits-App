import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/app_branding_row.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/version_badge.dart';

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const AppBrandingRow(), Gap(14.h), const VersionBadge()],
      ),
    );
  }
}
