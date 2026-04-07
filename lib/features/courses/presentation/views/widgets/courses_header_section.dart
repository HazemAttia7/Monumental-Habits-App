import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:provider/provider.dart';

class CoursesHeaderSection extends StatelessWidget {
  const CoursesHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
            Text("Courses", style: AppStyles.textStyle18),
            CustomIconButton(
              onTap: () {
                // TODO : make animated search field
              },
              icon: FontAwesomeIcons.magnifyingGlass,
            ),
          ],
        ),
        Gap(32.h),
        Image.asset(AssetsData.coursesCard, fit: BoxFit.cover),
      ],
    );
  }
}
