import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:provider/provider.dart';

class HeaderContainer extends StatelessWidget {
  final VoidCallback? onSearchTap;
  const HeaderContainer({super.key, this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          onTap: () => Provider.of<MainViewController>(
            context,
            listen: false,
          ).openSideMenu(),
          icon: FontAwesomeIcons.equals,
        ),
        Text('Courses', style: AppStyles.textStyle18),
        CustomIconButton(
          onTap: onSearchTap ?? () {},
          icon: FontAwesomeIcons.magnifyingGlass,
        ),
      ],
    );
  }
}
