import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/edit_profile_bottom_sheet.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          onTap: () => GoRouter.of(context).pop(),
          iconColor: AppColors.secondaryColor,
          icon: FontAwesomeIcons.arrowLeft,
        ),
        Text("Profile", style: AppStyles.textStyle18),
        CustomIconButton(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => const EditProfileBottomSheet(),
            );
          },
          iconColor: AppColors.secondaryColor,
          icon: FontAwesomeIcons.pencil,
        ),
      ],
    );
  }
}
