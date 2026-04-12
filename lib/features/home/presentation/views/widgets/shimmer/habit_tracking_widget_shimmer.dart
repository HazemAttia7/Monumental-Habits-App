import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:shimmer/shimmer.dart';

class HabitTrackingWidgetShimmer extends StatelessWidget {
  const HabitTrackingWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        height: 70.h,
        width: double.infinity,
        padding: EdgeInsets.only(left: 18.w, top: 12.h, bottom: 12.h),
        margin: EdgeInsets.only(bottom: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade100,
                  child: Text(
                    "HABIT NAME",
                    style: AppStyles.textStyle14.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 50.sp,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade400,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
