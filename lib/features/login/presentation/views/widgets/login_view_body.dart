import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/login/presentation/views/widgets/gradient_login_background.dart';
import 'package:pixel_true_app/features/login/presentation/views/widgets/login_view_body_content.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(AssetsData.loginBackground),
          ),
          const Positioned(child: GradientLoginBackground()),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
              child: const LoginViewBodyContent(),
            ),
          ),
        ],
      ),
    );
  }
}
