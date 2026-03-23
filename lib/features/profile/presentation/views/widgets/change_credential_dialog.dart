import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/confirmation_dialog.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';

class ChangeCredentialDialog extends StatefulWidget {
  final String title, subtitle, hint, confirmMessage;
  final String? loadingMessage;
  final bool isPassword;
  final Future<bool> Function(String) onConfirm;
  final String? Function(String?)? validator;
  final Function(String)? afterPop;

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
  });

  @override
  State<ChangeCredentialDialog> createState() => _ChangeCredentialDialogState();
}

class _ChangeCredentialDialogState extends State<ChangeCredentialDialog> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _handleConfirm() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final success = await widget.onConfirm(controller.text);

    if (!mounted) return;
    setState(() => _isLoading = false);
    if (success) {
      Navigator.of(context).pop();
      widget.afterPop?.call(controller.text);
    }
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
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title, style: AppStyles.textStyle24),
              Gap(24.h),
              Text(widget.subtitle, style: AppStyles.textStyle14),
              Gap(8.h),
              CustomTextFormField(
                controller: controller,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                hintText: widget.hint,
                isPassword: widget.isPassword,
                validator: widget.validator,
              ),
              Gap(12.h),
              CustomButton(
                onTap: _isLoading
                    ? () {}
                    : () {
                        if (!_formKey.currentState!.validate()) {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                          return;
                        }
                        showDialog(
                          context: context,
                          builder: (_) => ConfirmationDialog(
                            onConfirm: _handleConfirm, // ← clean reference
                            confirmationMessage: widget.confirmMessage,
                            confirmButtonText: "Change",
                          ),
                        );
                      },
                text: _isLoading
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
  }
}
