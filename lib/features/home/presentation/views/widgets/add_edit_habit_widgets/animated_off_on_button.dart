import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class AnimatedOffOnButton extends StatelessWidget {
  final bool isOn;
  final Function(bool isOn) onTap;

  const AnimatedOffOnButton({
    super.key,
    required this.onTap,
    required this.isOn,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: () => onTap(!isOn),
        customBorder: const StadiumBorder(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
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
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: isOn ? Alignment.centerLeft : Alignment.centerRight,
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
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
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
                        color:
                            (isOn
                                    ? AppColors.secondaryColor
                                    : AppColors.primaryColor)
                                .withValues(alpha: .5),
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
