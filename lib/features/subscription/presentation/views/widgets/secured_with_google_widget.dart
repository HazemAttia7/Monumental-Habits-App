import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/icon_text_widget.dart';

class SecuredWithGoogleWidget extends StatelessWidget {
  const SecuredWithGoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconTextWidget(
          icon: Icons.verified_user_outlined,
          text: "Secured with Goggle Play. Cancel anytime",
          textColor: AppColors.secondaryColor,
          themeColor: AppColors.secondaryColor,
        ),
      ],
    );
  }
}
