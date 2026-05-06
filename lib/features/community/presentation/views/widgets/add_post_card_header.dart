import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/user_meta_row.dart';

class AddPostCardHeader extends StatelessWidget {
  const AddPostCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
          bloc: context.read<AuthCubit>(),
          builder: (BuildContext context, AuthState state) => UserMetaRow(
            userName: context.read<AuthCubit>().currentUser!.name,
            displayName: "You",
          ),
        ),
        Gap(12.h),
        Divider(
          color: AppColors.primaryColor.withValues(alpha: .1),
          thickness: 2.w,
          height: 1,
        ),
        Gap(12.h),
      ],
    );
  }
}
