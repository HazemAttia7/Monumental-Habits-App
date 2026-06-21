import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/setting_card.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        SettingCard(
          title: 'Connect',
          icon: FontAwesomeIcons.diamond,
          onTap: () => GoRouter.of(context).push(AppRouter.kConnect),
        ),
        SettingCard(
          title: 'Feedback',
          icon: FontAwesomeIcons.solidComment,
          onTap: () {
            // TODO : rate app
          },
        ),
        SettingCard(
          title: 'Privacy Policy',
          icon: FontAwesomeIcons.shield,
          onTap: () => GoRouter.of(context).push(AppRouter.kPrivacyPolicy),
        ),
        SettingCard(
          title: 'About',
          icon: FontAwesomeIcons.circleExclamation,
          onTap: () => GoRouter.of(context).push(AppRouter.kAboutUs),
        ),
      ],
    );
  }
}
