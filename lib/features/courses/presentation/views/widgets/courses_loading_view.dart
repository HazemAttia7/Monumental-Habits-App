import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/header_container.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/shimmer/courses_list_shimmer.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/shimmer/courses_sort_filter_row_shimmer.dart';
import 'package:pixel_true_app/core/widgets/shimmer/image_shimmer.dart';

class CoursesLoadingView extends StatelessWidget {
  const CoursesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Gap(10.h),
              const HeaderContainer(),
              Gap(24.h),
              ImageShimmer(height: 147.h, borderRadius: 21.r),
              Gap(16.h),
              const CoursesSortFilterRowShimmer(),
              Gap(16.h),
              const CoursesListShimmer(),
              Gap(100.h),
            ],
          ),
        ),
      ),
    );
  }
}
