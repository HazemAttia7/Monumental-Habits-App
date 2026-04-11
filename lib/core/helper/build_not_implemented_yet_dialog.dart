import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

void buildNotImplementedYetDialog(
  BuildContext context, {
  required String featureName,
}) {
  showDialog<void>(
    context: context,
    builder: (_) => _NotImplementedYetDialog(featureName: featureName),
  );
}

class _NotImplementedYetDialog extends StatelessWidget {
  final String featureName;
  const _NotImplementedYetDialog({required this.featureName});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconContainer(
              icon: Icons.info_outline_rounded,
              iconColor: AppColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            Gap(20.h),
            Text(
              'COMING SOON',
              style: AppStyles.textStyle12.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            Gap(6.h),
            Text(
              featureName,
              style: AppStyles.textStyle20.copyWith(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(10.h),
            Text(
              "This feature isn't available yet. We're working on it and it'll be ready soon.",
              style: AppStyles.textStyle14.copyWith(
                color: AppColors.secondaryColor.withValues(alpha: 0.6),
                height: 1.65,
              ),
            ),
            Gap(24.h),
            const Divider(color: Color(0x1F573353), height: 1),
            Gap(20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Got it',
                  style: AppStyles.textStyle14.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
