import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          BlocProvider.of<AuthCubit>(context).currentUser!.name,
          style: AppStyles.textStyle16,
        ),
        Text(
          "Name",
          style: AppStyles.textStyle12.copyWith(
            color: AppColors.primaryColor.withValues(alpha: .5),
          ),
        ),
      ],
    );
  }
}
