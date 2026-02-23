import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class AnimatedOffOnButton extends StatefulWidget {
  final VoidCallback onTap;
  const AnimatedOffOnButton({super.key, required this.onTap});

  @override
  State<AnimatedOffOnButton> createState() => _AnimatedOffOnButtonState();
}

class _AnimatedOffOnButtonState extends State<AnimatedOffOnButton> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            isOn = !isOn;
          });
          widget.onTap.call();
        },
        borderRadius: BorderRadius.circular(9999.r),
        child: Container(
          width: 60.w,
          height: 30.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isOn
                ? AppColors.secondaryColor.withValues(alpha: .1)
                : AppColors.primaryColor.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                alignment: isOn ? Alignment.centerLeft : Alignment.centerRight,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      isOn ? "On" : "Off",
                      key: ValueKey(isOn),
                      style: AppStyles.textStyle12.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isOn
                            ? AppColors.secondaryColor
                            : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedAlign(
                alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                child: Container(
                  width: 22.sp,
                  height: 22.sp,
                  decoration: BoxDecoration(
                    color: isOn
                        ? AppColors.secondaryColor
                        : AppColors.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(-2, 2),
                        color: isOn
                            ? AppColors.secondaryColor.withValues(alpha: .5)
                            : AppColors.primaryColor.withValues(alpha: .5),
                        spreadRadius: 0,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
