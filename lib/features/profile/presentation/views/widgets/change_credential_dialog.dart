import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/confirmation_dialog.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';

class ChangeCredentialDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String hint;
  final String confirmMessage;
  final bool isPassword;
  final Future<void> Function(String value) onConfirm;
  final VoidCallback? afterPop;
  final String? Function(String?)? validator;

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
  });

  @override
  State<ChangeCredentialDialog> createState() => _ChangeCredentialDialogState();
}

class _ChangeCredentialDialogState extends State<ChangeCredentialDialog> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    controller.dispose();
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
                onTap: isLoading
                    ? () {}
                    : () async {
                        if (!_formKey.currentState!.validate()) {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                          return;
                        }
                        final outerContext = context;
                        showDialog(
                          context: context,
                          builder: (_) => ConfirmationDialog(
                            onConfirm: () async {
                              setState(() => isLoading = true);

                              try {
                                await widget.onConfirm(controller.text);
                              } finally {
                                if (mounted) {
                                  setState(() => isLoading = false);
                                  Navigator.pop(outerContext);
                                  widget.afterPop?.call();
                                }
                              }
                            },
                            confirmationMessage: widget.confirmMessage,
                            confirmButtonText: "Change",
                          ),
                        );
                      },
                text: isLoading ? "Loading..." : "Change",
                backColor: isLoading ? Colors.grey : AppColors.primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
