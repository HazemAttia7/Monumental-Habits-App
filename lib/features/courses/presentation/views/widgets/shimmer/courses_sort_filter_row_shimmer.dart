import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CoursesSortFilterRowShimmer extends StatelessWidget {
  const CoursesSortFilterRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        children: [
          Container(
            height: 20.h,
            width: 65.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: Colors.grey.shade300,
            ),
          ),
          Gap(8.w),
          _buildDropdownPlaceholder(),
          const Spacer(),
          _buildDropdownPlaceholder(),
        ],
      ),
    );
  }

  Container _buildDropdownPlaceholder() {
    return Container(
      height: 40.h,
      width: 110.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey.shade300,
      ),
    );
  }
}