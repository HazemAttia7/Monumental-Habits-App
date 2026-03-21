import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/change_credential_dialog.dart';
import 'package:provider/provider.dart';

class PasswordConfirmationDialog extends StatefulWidget {
  final String title, subtitle, hint, confirmMessage;
  final String? loadingMessage;
  final bool isPassword;
  final Future<bool> Function(String) onConfirm;
  final String? Function(String?)? validator;
  final void Function(String password)? onPasswordVerified;
  final Function(String)? afterPop;

  const PasswordConfirmationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.hint,
    required this.confirmMessage,
    required this.isPassword,
    required this.onConfirm,
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
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _verifyPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final cubit = context.read<AuthCubit>();

    final isCorrect = await cubit.verifyPassword(
      password: _passwordController.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (isCorrect) {
      widget.onPasswordVerified?.call(_passwordController.text);
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => ChangeCredentialDialog(
          title: widget.title,
          subtitle: widget.subtitle,
          hint: widget.hint,
          confirmMessage: widget.confirmMessage,
          isPassword: false,
          onConfirm: widget.onConfirm,
          validator: widget.validator,
          afterPop: widget.afterPop,
          loadingMessage: widget.loadingMessage,
        ),
      );
    } else {
      setState(() => _errorMessage = "Incorrect password, please try again.");
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
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
            if (_errorMessage != null) ...[
              Gap(6.h),
              Text(
                _errorMessage!,
                style: AppStyles.textStyle14.copyWith(color: Colors.red),
              ),
            ],
            Gap(12.h),
            CustomButton(
              onTap: _isLoading ? () {} : _verifyPassword,
              text: _isLoading ? "Verifying..." : "Confirm",
              backColor: AppColors.primaryColor,
              textColor: Colors.white,
            ),
            Gap(8.h),
          ],
        ),
      ),
    );
  }
}
