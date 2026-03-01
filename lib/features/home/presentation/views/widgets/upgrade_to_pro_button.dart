import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class UpgradeToProButton extends StatefulWidget {
  final VoidCallback onTap;
  const UpgradeToProButton({super.key, required this.onTap});

  @override
  State<UpgradeToProButton> createState() => _UpgradeToProButtonState();
}

class _UpgradeToProButtonState extends State<UpgradeToProButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, _isPressed ? 0 : 8),
            color: const Color(0xffE8914A),
            spreadRadius: 0,
            blurRadius: 0,
          ),
        ],
      ),
      transform: Matrix4.translationValues(0, _isPressed ? 8 : 0, 0),
      child: Material(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          splashColor: Colors.white.withValues(alpha: .3),
          borderRadius: BorderRadius.circular(16.r),
          onTap: () async {
            setState(() => _isPressed = true);
            await Future.delayed(const Duration(milliseconds: 150));
            setState(() => _isPressed = false);
            widget.onTap();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.workspace_premium, color: Colors.white, size: 18.sp),
                Text(
                  "UPGRADE TO PRO",
                  style: AppStyles.textStyle16.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
