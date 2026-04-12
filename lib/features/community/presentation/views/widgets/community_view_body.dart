import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/view_header.dart';

class CommunityViewBody extends StatelessWidget {
  const CommunityViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          children: [
            Gap(10.h),
            const ViewHeader(header: "Community"),
            Gap(36.h),
          ],
        ),
      ),
    );
  }
}
