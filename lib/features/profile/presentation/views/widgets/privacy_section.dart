import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/validator.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/change_credential_dialog.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/edit_profile_section_header.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/password_confirmation_dialog.dart';
import 'package:provider/provider.dart';

class PrivacySection extends StatelessWidget {
  const PrivacySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EditProfileSectionHeader(text: "Privacy"),
        Gap(12.h),
        Row(
          spacing: 16.w,
          children: [
            Expanded(
              child: CustomButton(
                text: "Edit Email",
                onTap: () {
                  final cubit = context.read<AuthCubit>();
                  showDialog(
                    context: context,
                    builder: (dialogContext) => PasswordConfirmationDialog(
                      title: "Change Email",
                      subtitle: "Enter your new email address",
                      hint: "Enter your email",
                      confirmMessage:
                          "Are you sure you want to change your email?",
                      isPassword: false,
                      onConfirm: (email) async {
                        await cubit.changeEmail(newEmail: email.trim());
                      },
                      afterPop: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              EmailConfirmationDialog(cubit: cubit),
                        );
                      },
                      validator: Validator.validateEmail,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: CustomButton(
                text: "Edit Password",
                onTap: () {
                  final cubit = context.read<AuthCubit>();
                  showDialog(
                    context: context,
                    builder: (dialogContext) => ChangeCredentialDialog(
                      title: "Change Password",
                      subtitle: "Enter your new password",
                      hint: "Enter your password",
                      confirmMessage:
                          "Are you sure you want to change your password?",
                      isPassword: true,
                      onConfirm: (newPass) async {
                        await cubit.changePassword(newPassword: newPass);
                      },
                      validator: Validator.validatePassword,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Gap(24.h),
        Divider(
          color: AppColors.primaryColor.withValues(alpha: .2),
          thickness: 1.w,
        ),
        Gap(24.h),
      ],
    );
  }
}

class EmailConfirmationDialog extends StatelessWidget {
  final AuthCubit cubit;
  const EmailConfirmationDialog({super.key, required this.cubit});

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
