import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/connect/presentation/views/widgets/social_card.dart';

class FindMeOnlineSection extends StatelessWidget {
  const FindMeOnlineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "FIND ME ONLINE",
          style: AppStyles.textStyle16.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColor.withValues(alpha: .5),
          ),
        ),
        Gap(16.h),
        SocialCard(
          title: 'LinkedIn - Hazem Attia',
          subtitle: 'Professional network & career',
          icon: FontAwesomeIcons.linkedinIn,
          themeColor: AppColors.twilight,
          onTap: () {
            // TODO : open linkedin link
          },
        ),
        Gap(12.h),
        SocialCard(
          title: 'GitHub - HazemAttia7',
          subtitle: 'Code, projects & contributions',
          icon: FontAwesomeIcons.github,
          themeColor: AppColors.sunset,
          onTap: () {
            // TODO : open github link
          },
        ),
      ],
    );
  }
}
