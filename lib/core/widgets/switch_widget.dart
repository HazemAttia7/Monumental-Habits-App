import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/animated_off_on_button.dart';

class SwitchWidget extends StatelessWidget {
  final Color? themeColor;
  final Function(bool isOn) onToggle;
  final bool isOn;
  final String text;
  const SwitchWidget({
    super.key,
    this.themeColor,
    required this.onToggle,
    required this.isOn,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
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
            text,
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
          ),
          AnimatedOffOnButton(
            themeColor: themeColor ?? AppColors.primaryColor,
            onTap: onToggle,
            isOn: isOn,
          ),
        ],
      ),
    );
  }
}
