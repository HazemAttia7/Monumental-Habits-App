import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CourseCardShimmer extends StatelessWidget {
  const CourseCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Column(
            children: [
              Container(
                height: 166.h,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade300),
              ),
              Container(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  children: [
                    Container(
                      height: 16.h,
                      width: double.infinity,
                      decoration: _decoration(),
                    ),
                    Gap(8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Duration
                              Container(
                                height: 12.h,
                                width: 80.w,
                                decoration: _decoration(),
                              ),
                              Gap(4.h),
                              Container(
                                height: 12.h,
                                width: 60.w,
                                decoration: _decoration(),
                              ),
                            ],
                          ),
                          Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(2.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(6.r),
    );
  }
}
