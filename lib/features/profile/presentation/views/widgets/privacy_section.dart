import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/validator.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/change_credential_dialog.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/edit_profile_section_header.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/email_confirmation_dialog.dart';
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
                          builder: (context) => BlocProvider.value(
                            value: cubit,
                            child: const EmailConfirmationDialog(),
                          ),
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
