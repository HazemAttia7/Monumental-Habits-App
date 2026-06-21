import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/check_profile_widget.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/setting_card.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/settings_view_header.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10.h),
            const SettingsViewHeader(),
            Gap(32.h),
            const CheckProfileWidget(),
            Gap(16.h),
            const _SectionTitle(),
            Gap(16.h),
            Column(
              spacing: 12.h,
              children: [
                SettingCard(
                  title: 'Notifications',
                  subtitle: 'Customize notifications',
                  icon: Icons.circle_notifications_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      "General",
      style: AppStyles.textStyle18.copyWith(fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }
}
