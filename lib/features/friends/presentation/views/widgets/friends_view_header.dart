import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';

class FriendsViewHeader extends StatelessWidget {
  const FriendsViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          onTap: () => Navigator.pop(context),
          iconColor: AppColors.secondaryColor,
          backColor: AppColors.secondaryColor.withValues(alpha: .1),
          icon: FontAwesomeIcons.arrowLeft,
        ),
        Text(
          "Friends",
          style: AppStyles.textStyle20,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        CustomIconButton(
          onTap: () {
            // TODO : implement add friend
          },
          iconColor: AppColors.secondaryColor,
          backColor: Colors.transparent,
          icon: FontAwesomeIcons.userPlus,
        ),
      ],
    );
  }
}
