import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class UserMetaInfoShimmer extends StatelessWidget {
  const UserMetaInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 36.w,
            height: 36.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        Gap(10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 10.h,
                width: 60.w,
                decoration: _decoration(),
              ),
            ),
            Gap(4.h),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 10.h,
                width: 40.w,
                decoration: _decoration(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  BoxDecoration _decoration() => BoxDecoration(
    color: Colors.grey.shade300,
    borderRadius: BorderRadius.circular(9999.r),
  );
}
