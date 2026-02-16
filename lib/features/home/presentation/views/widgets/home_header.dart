import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_circle_icon_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_button.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomCircleIconButton(
          onTap: () {
            // TODO : Open Side Menu
          },
          icon: FontAwesomeIcons.bars,
        ),
        Text("Home Page", style: AppStyles.textStyle18),
        CustomTextButton(
          backColor: AppColors.primaryColor,
          textColor: AppColors.scaffoldColor,
          onTap: () {
            // TODO : Open Profile
          },
          text: BlocProvider.of<AuthCubit>(
            context,
          ).currentUser!.name.substring(0, 2).toUpperCase(),
        ),
      ],
    );
  }
}
