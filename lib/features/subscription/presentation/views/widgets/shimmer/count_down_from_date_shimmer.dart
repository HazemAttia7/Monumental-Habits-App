import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:shimmer/shimmer.dart';

class CountDownFromDateShimmer extends StatelessWidget {
  const CountDownFromDateShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (i) => Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 52.w,
                height: 52.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            if (i < 2)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(":", style: AppStyles.textStyle20),
              ),
          ],
        ),
      ),
    );
  }
}
