import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/setting_card.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        SettingCard(
          title: 'Contact',
          icon: FontAwesomeIcons.phone,
          onTap: () {
            // TODO : navigate to contact
          },
        ),
        SettingCard(
          title: 'Feedback',
          icon: FontAwesomeIcons.solidComment,
          onTap: () {
            // TODO : open coming soon dialog
          },
        ),
        SettingCard(
          title: 'Privacy Policy',
          icon: FontAwesomeIcons.shield,
          onTap: () {
            // TODO : navigate to privacy policy
          },
        ),
        SettingCard(
          title: 'About',
          icon: FontAwesomeIcons.circleExclamation,
          onTap: () {
            // TODO :  navigate to about
          },
        ),
      ],
    );
  }
}
