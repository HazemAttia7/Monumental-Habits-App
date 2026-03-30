import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/validator.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_handler.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/profile/presentation/managers/profile_controller.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/change_credential_dialog.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/edit_profile_section_header.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/password_confirmation_dialog.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/privacy_section.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isGoogleUser = context.read<AuthCubit>().isGoogleUser;
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
          if (!isGoogleUser) const PrivacySection(),
          const EditProfileSectionHeader(text: "Display"),
          Gap(12.h),
          CustomButton(
            text: "Change Username",
            onTap: () {
              final cubit = context.read<AuthCubit>();
              final controller = context.read<ProfileController>();
              // TODO : make manual closing of dialog and set barrierDismissible: false,
              showDialog(
                context: context,
                builder: (context) => BlocProvider.value(
                  value: cubit,
                  child: _buildChangeUsernameDialog(
                    context,
                    isGoogleUser,
                    cubit,
                    controller,
                  ),
                ),
              );
            },
          ),
          Gap(18.h),
        ],
      ),
    );
  }

  StatefulWidget _buildChangeUsernameDialog(
    BuildContext context,
    bool isGoogleUser,
    AuthCubit cubit,
    ProfileController controller,
  ) {
    return isGoogleUser
        ? ChangeCredentialDialog(
            title: "Change Username",
            subtitle: "Enter your new username",
            hint: "Enter your username",
            confirmMessage: "Are you sure you want to change your username?",
            isPassword: false,
            onConfirm: (username) =>
                controller.changeUsername(username, context, cubit),
            validator: Validator.validateUsername,
            profileController: controller,
          )
        : PasswordConfirmationDialog(
            title: "Change Username",
            subtitle: "Enter your new username",
            hint: "Enter your username",
            confirmMessage: "Are you sure you want to change your username?",
            isPassword: false,
            onConfirm: (username) =>
                controller.changeUsername(username, context, cubit),
            validator: Validator.validateUsername,
            profileController: controller,
          );
  }
}
