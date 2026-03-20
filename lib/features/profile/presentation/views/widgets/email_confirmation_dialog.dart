import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class EmailConfirmationDialog extends StatelessWidget {
  const EmailConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Text(
        "Please confirm your new email by clicking the verification link sent to your inbox.",
        style: AppStyles.textStyle16,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: CustomButton(
            text: "I've verified my email",
            onTap: () async {
              final cubit = context.read<AuthCubit>();
              final verified = await cubit.verifyAndSyncEmail();

              if (verified) {
                Navigator.pop(context); // close dialog
                buildSuccessSnackBar(
                  context,
                  message: "Your email has been successfully updated",
                );
              } else {
                buildClosableSnackBar(
                  context,
                  message: "Please verify your email first",
                );
              }
            },
          ),
        ),
        CustomButton(
          text: "Nevermind",
          onTap: () => Navigator.pop(context),
          backColor: AppColors.primaryColor,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
