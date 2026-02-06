import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/or_sign_in_with_row.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/sign_in_with_button.dart';

class SignInWithSection extends StatefulWidget {
  const SignInWithSection({super.key});

  @override
  State<SignInWithSection> createState() => _SignInWithSectionState();
}

class _SignInWithSectionState extends State<SignInWithSection> {
  bool _isLoading = false;
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
                image: AssetsData.googleIcon,
                onTap: signupWithGoogle,
                isLoading: _isLoading,
              ),
            ),
            Expanded(
              child: SignInWithButton(
                text: "Facebook",
                image: AssetsData.facebookIcon,
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

  void signupWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    await BlocProvider.of<AuthCubit>(context).signupWithGoogle();
    setState(() {
      _isLoading = false;
    });
  }
}
