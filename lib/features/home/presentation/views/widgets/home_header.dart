import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          onTap: () {
            Provider.of<MainViewController>(
              context,
              listen: false,
            ).openSideMenu();
          },
          icon: FontAwesomeIcons.bars,
        ),
        Text("Home Page", style: AppStyles.textStyle18),
        Container(
          padding: EdgeInsets.all(11.sp),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
          child: Text(
            BlocProvider.of<AuthCubit>(
              context,
            ).currentUser!.name.substring(0, 2).toUpperCase(),
            style: AppStyles.textStyle16.copyWith(
              color: AppColors.scaffoldColor,
            ),
          ),
        ),
      ],
    );
  }
}
