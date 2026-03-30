import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/managers/add_edit_habit_view_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/animated_off_on_button.dart';
import 'package:provider/provider.dart';

class NotificationsWidget extends StatelessWidget {
  final Color? themeColor;
  const NotificationsWidget({super.key, this.themeColor});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddEditHabitViewController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Notification",
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
          ),
          AnimatedOffOnButton(
            themeColor: themeColor ?? AppColors.primaryColor,
            onTap: controller.onNotificationToggle,
            isOn: controller.isNotificationOn,
          ),
        ],
      ),
    );
  }
}
