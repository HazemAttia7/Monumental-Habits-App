import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:provider/provider.dart';

class EmailConfirmationDialog extends StatefulWidget {
  final String email, password;

  const EmailConfirmationDialog({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<EmailConfirmationDialog> createState() =>
      _EmailConfirmationDialogState();
}

class _EmailConfirmationDialogState extends State<EmailConfirmationDialog> {
  String otpCode = "";
  bool isLoading = false;

  Future<bool> verifyOtp() async {
    if (otpCode.length < 6) return false;

    if (EmailOTP.isOtpExpired()) {
      buildClosableSnackBar(context, message: "OTP expired, please try again.");
      return false;
    }

    setState(() => isLoading = true);

    final result = EmailOTP.verifyOTP(otp: otpCode);

    setState(() => isLoading = false);

    if (result) {
      buildSuccessSnackBar(context, message: "Email changed successfully.");
      return true;
    } else {
      buildErrorSnackBar(context, message: "Invalid OTP");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 55.h,
      textStyle: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
    );

    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Enter the code sent to\n${widget.email}",
            style: AppStyles.textStyle16,
            textAlign: TextAlign.center,
          ),
          Gap(20.h),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            onChanged: (value) => otpCode = value,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: CustomButton(
            text: isLoading ? "Verifying..." : "Verify",
            onTap: isLoading
                ? () {}
                : () async {
                    setState(() => isLoading = true);
                    await verifyOtp().then((value) {
                      if (value) {
                        setState(() => isLoading = false);
                        context.read<AuthCubit>().changeEmail(
                          newEmail: widget.email,
                          currentPassword: widget.password,
                        );
                        Navigator.pop(context);
                      }
                    });
                    setState(() => isLoading = false);
                  },
          ),
        ),
        CustomButton(
          text: "Cancel",
          onTap: () => Navigator.pop(context),
          backColor: AppColors.primaryColor,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
