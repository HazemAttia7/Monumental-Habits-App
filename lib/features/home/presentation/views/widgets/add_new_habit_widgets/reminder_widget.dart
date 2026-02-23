import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/text_icon_widget.dart';

class ReminderWidget extends StatelessWidget {
  const ReminderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Reminder",
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
          ),
          TextIconWidget(
            text: "10:00 AM",
            icon: FontAwesomeIcons.chevronRight,
            color: AppColors.secondaryColor,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
