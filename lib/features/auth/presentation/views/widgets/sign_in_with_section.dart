import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/or_sign_in_with_row.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/sign_in_with_button.dart';

class SignInWithSection extends StatelessWidget {
  const SignInWithSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrSignInWithRow(),
        Gap(20.h),
        Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: SignInWithButton(
                text: "Google",
                image: AssetsData.googleImge,
                onTap: () {
                  // TODO : Login With Google
                },
              ),
            ),
            Expanded(
              child: SignInWithButton(
                text: "Facebook",
                image: AssetsData.facebookImage,
                onTap: () {
                  // TODO : Login With Facebook
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
