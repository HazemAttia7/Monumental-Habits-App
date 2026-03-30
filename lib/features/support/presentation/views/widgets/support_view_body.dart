import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/support/presentation/views/widgets/contact_us_widget.dart';
import 'package:pixel_true_app/features/support/presentation/views/widgets/faq_section.dart';

// TODO : refactor code by using controller
class SupportViewBody extends StatelessWidget {
  const SupportViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(12.h),
              const DefaultViewHeader(title: "Support"),
              Gap(32.h),
              const FAQSection(),
              Gap(36.h),
              const ContactUsWidget(),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
