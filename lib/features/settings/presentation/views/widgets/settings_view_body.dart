import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/check_profile_widget.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/general_settings_section.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/settings_view_header.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/support_section.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),
              const SettingsViewHeader(),
              Gap(32.h),
              const CheckProfileWidget(),
              Gap(16.h),
              const _SectionTitle(title: 'General'),
              Gap(16.h),
              const GeneralSettingsSection(),
              Gap(16.h),
              const _SectionTitle(title: 'Support'),
              Gap(16.h),
              const SupportSection(),
              Gap(128.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppStyles.textStyle18.copyWith(fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }
}
