import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/side_menu_cliackable_text.dart';

class MoreActions extends StatelessWidget {
  const MoreActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SideMenuClickableText(text: "About Us", onTap: () {
          // TODO : Navigate to about us page
        }),
        SideMenuClickableText(
          text: "Log Out",
          onTap: () {
            BlocProvider.of<AuthCubit>(context).logout();
          },
        ),
      ],
    );
  }
}
