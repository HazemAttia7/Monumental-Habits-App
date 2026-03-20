import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class ProfilePlaceholder extends StatelessWidget {
  final double? width, height, fontSize;
  const ProfilePlaceholder({super.key, this.width, this.height, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(11.sp),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: Text(
          context
              .watch<AuthCubit>()
              .currentUser!
              .name
              .substring(0, 2)
              .toUpperCase(),
          style: AppStyles.textStyle16.copyWith(
            color: AppColors.scaffoldColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
