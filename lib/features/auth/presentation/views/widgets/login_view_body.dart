import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/gradient_login_background_and_content.dart';

class LoginViewBody extends StatelessWidget {
  final VoidCallback togglePages;
  const LoginViewBody({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Image.asset(AssetsData.loginBackground),
        ),
        Positioned(
          child: GradientLoginBackgroundAndContent(togglePages: togglePages),
        ),
      ],
    );
  }
}
