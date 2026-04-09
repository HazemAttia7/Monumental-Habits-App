import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/header_container.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/shimmer/courses_list_shimmer.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/shimmer/courses_sort_filter_row_shimmer.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/shimmer/image_shimmer.dart';

class CoursesLoadingView extends StatelessWidget {
  const CoursesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(10.h),
                  const HeaderContainer(),
                  Gap(24.h),
                  const ImageShimmer(),
                  Gap(16.h),
                  const CoursesSortFilterRowShimmer(),
                  Gap(16.h),
                ],
              ),
            ),
            const CoursesListShimmer(),
            SliverToBoxAdapter(child: Gap(100.h)),
          ],
        ),
      ),
    );
  }
}
