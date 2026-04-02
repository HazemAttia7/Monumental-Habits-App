import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          children: [
            Gap(12.h),
            const DefaultViewHeader(title: "About Us"),
          ],
        ),
      ),
    );
  }
}