import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/profile/presentation/managers/profile_controller.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/change_credential_dialog.dart';

class PasswordConfirmationDialog extends StatefulWidget {
  final String title, subtitle, hint, confirmMessage;
  final String? loadingMessage;
  final bool isPassword;
  final Future<bool> Function(String) onConfirm;
  final String? Function(String?)? validator;
  final void Function(String password)? onPasswordVerified;
  final Function(String)? afterPop;
  final ProfileController profileController;

  const PasswordConfirmationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.hint,
    required this.confirmMessage,
    required this.isPassword,
    required this.onConfirm,
    required this.profileController,
    this.validator,
    this.onPasswordVerified,
    this.afterPop,
    this.loadingMessage,
  });

  @override
  State<PasswordConfirmationDialog> createState() =>
      _PasswordConfirmationDialogState();
}

class _PasswordConfirmationDialogState
    extends State<PasswordConfirmationDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.profileController.clearPasswordError();
    });
    super.dispose();
  }

  void _verifyPassword() {
    final cubit = context.read<AuthCubit>();

    widget.profileController.verifyPassword(
      context: context,
      password: _passwordController.text,
      cubit: cubit,
      onSuccess: () {
        widget.onPasswordVerified?.call(_passwordController.text);
        Navigator.of(context).pop();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ChangeCredentialDialog(
            profileController: widget.profileController,
            title: widget.title,
            subtitle: widget.subtitle,
            hint: widget.hint,
            confirmMessage: widget.confirmMessage,
            isPassword: widget.isPassword,
            onConfirm: widget.onConfirm,
            validator: widget.validator,
            afterPop: widget.afterPop,
            loadingMessage: widget.loadingMessage,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.profileController,
      builder: (context, _) {
        final isLoading = widget.profileController.isPasswordVerifying;
        final errorMessage = widget.profileController.passwordError;

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Confirm Password", style: AppStyles.textStyle24),
                    Gap(24.h),
                    Text(
                      "Enter your current password to continue",
                      style: AppStyles.textStyle14,
                    ),
                    Gap(8.h),
                    SizedBox(
                      height: 55.h,
                      child: CustomTextFormField(
                        controller: _passwordController,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        hintText: "Enter your password",
                        isPassword: true,
                      ),
                    ),
                    if (errorMessage != null) ...[
                      Gap(6.h),
                      Text(
                        errorMessage,
                        style: AppStyles.textStyle14.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ],
                    Gap(12.h),
                    CustomButton(
                      onTap: isLoading ? () {} : _verifyPassword,
                      text: isLoading ? "Verifying..." : "Confirm",
                      backColor: AppColors.secondaryColor,
                      textColor: Colors.white,
                    ),
                    Gap(8.h),
                  ],
                ),
              ),
              Positioned(
                top: 6.h,
                right: 6.w,
                child: CustomIconButton(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.close,
                  padding: EdgeInsets.all(4.sp),
                  iconSize: 18.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
