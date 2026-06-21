import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:provider/provider.dart';

class SettingsViewHeader extends StatelessWidget {
  const SettingsViewHeader({super.key});

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
          icon: FontAwesomeIcons.equals,
        ),
        Expanded(
          child: Center(
            child: Text(
              "Settings",
              style: AppStyles.textStyle20,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(11.sp),
          child: Icon(Icons.circle, size: 22.sp, color: Colors.transparent),
        ),
      ],
    );
  }
}
