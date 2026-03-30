import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/confirmation_dialog.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/profile/presentation/managers/profile_controller.dart';

class ChangeCredentialDialog extends StatefulWidget {
  final String title, subtitle, hint, confirmMessage;
  final String? loadingMessage;
  final bool isPassword;
  final Future<bool> Function(String) onConfirm;
  final String? Function(String?)? validator;
  final Function(String)? afterPop;
  final ProfileController profileController;

  const ChangeCredentialDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.hint,
    required this.confirmMessage,
    this.isPassword = false,
    required this.onConfirm,
    this.validator,
    this.afterPop,
    this.loadingMessage,
    required this.profileController,
  });

  @override
  State<ChangeCredentialDialog> createState() => _ChangeCredentialDialogState();
}

class _ChangeCredentialDialogState extends State<ChangeCredentialDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChangeTapped() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      return;
    }

    showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        onConfirm: () => widget.profileController.handleCredentialConfirm(
          context: context,
          value: _controller.text,
          onConfirm: widget.onConfirm,
          afterPop: widget.afterPop,
        ),
        confirmationMessage: widget.confirmMessage,
        confirmButtonText: "Change",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.profileController,
      builder: (context, _) {
        final isLoading = widget.profileController.isDialogLoading;

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.title, style: AppStyles.textStyle24),
                  Gap(24.h),
                  Text(widget.subtitle, style: AppStyles.textStyle14),
                  Gap(8.h),
                  CustomTextFormField(
                    controller: _controller,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    hintText: widget.hint,
                    isPassword: widget.isPassword,
                    validator: widget.validator,
                  ),
                  Gap(12.h),
                  CustomButton(
                    onTap: isLoading ? () {} : _onChangeTapped,
                    text: isLoading
                        ? widget.loadingMessage ?? "Loading..."
                        : "Change",
                    backColor: AppColors.secondaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}