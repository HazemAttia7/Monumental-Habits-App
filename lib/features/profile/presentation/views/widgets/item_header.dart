import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/icon_button_with_shadow.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habit_title_row.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: HabitTitleRow()),
        IconButtonWithShadow(
          icon: FontAwesomeIcons.ellipsis,
          color: AppColors.secondaryColor,
          iconSize: 20.sp,
          onTap: () {
            // TODO : show habit analysis view
          },
        ),
      ],
    );
  }
}
