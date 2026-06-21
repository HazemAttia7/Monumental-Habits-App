import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/connect/presentation/views/widgets/social_card.dart';

class GetInTouchSection extends StatelessWidget {
  const GetInTouchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "GET IN TOUCH",
          style: AppStyles.textStyle16.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColor.withValues(alpha: .5),
          ),
        ),
        Gap(16.h),
        AbsorbPointer(
          absorbing: true,
          child: SocialCard(
            title: 'Email',
            subtitle: 'hazemco711@gmail.com',
            icon: FontAwesomeIcons.envelope,
            themeColor: AppColors.secondaryColor,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
