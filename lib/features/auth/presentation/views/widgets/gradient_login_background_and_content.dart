import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/login_view_body_content.dart';

class GradientLoginBackgroundAndContent extends StatelessWidget {
  final VoidCallback togglePages;
  const GradientLoginBackgroundAndContent({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.scaffoldColor.withAlpha(0),
              AppColors.scaffoldColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.18, 0.37],
          ),
        ),
        child:  LoginViewBodyContent(togglePages: togglePages),
      ),
    );
  }
}
