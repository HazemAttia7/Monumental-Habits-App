import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/validator.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_handler.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/change_credential_dialog.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomHandler(),
          Gap(12.h),
          _buildSectionText(text: "Privacy"),
          Gap(12.h),
          Row(
            spacing: 16.w,
            children: [
              Expanded(
                child: CustomButton(
                  text: "Edit Email",
                  onTap: () {
                    // TODO : Must enter password before changing email
                    showDialog(
                      context: context,
                      builder: (context) => ChangeCredentialDialog(
                        title: "Change Email",
                        subtitle: "Enter your new email address",
                        hint: "Enter your email",
                        confirmMessage:
                            "Are you sure you want to change your email?",
                        isPassword: false,
                        onConfirm: () {
                          // TODO: Change Email
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
                    showDialog(
                      context: context,
                      builder: (context) => ChangeCredentialDialog(
                        title: "Change Password",
                        subtitle: "Enter your new password",
                        hint: "Enter your password",
                        confirmMessage:
                            "Are you sure you want to change your password?",
                        isPassword: true,
                        onConfirm: () {
                          // TODO: Send change Password email
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
          _buildSectionText(text: "Display"),
          Gap(12.h),
          CustomButton(
            text: "Change Username",
            onTap: () {
              // TODO : Must enter password before changing username
              showDialog(
                context: context,
                builder: (context) => ChangeCredentialDialog(
                  title: "Change Username",
                  subtitle: "Enter your new username",
                  hint: "Enter your username",
                  confirmMessage:
                      "Are you sure you want to change your username?",
                  isPassword: false,
                  onConfirm: () {
                    // TODO: Change Username
                  },
                  validator: Validator.validateUsername,
                ),
              );
            },
          ),
          Gap(18.h),
        ],
      ),
    );
  }

  Text _buildSectionText({required String text}) {
    return Text(
      text,
      style: AppStyles.textStyle22.copyWith(
        color: AppColors.primaryColor.withValues(alpha: .75),
      ),
    );
  }
}
