import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sliver_list.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sort_filter_row.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/sliding_header_container.dart';

class CoursesLoadedView extends StatelessWidget {
  final List<Course> courses;
  const CoursesLoadedView({super.key, required this.courses});

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
                  const SlidingHeaderContainer(),
                  Gap(24.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(21.r),
                    child: Image.asset(
                      AssetsData.coursesCard,
                      fit: BoxFit.cover,
                      height: 147.h,
                    ),
                  ),
                  Gap(16.h),
                  const CoursesSortFilterRow(),
                  Gap(16.h),
                ],
              ),
            ),
            CoursesSliverList(courses: courses),
            SliverToBoxAdapter(child: Gap(100.h)),
          ],
        ),
      ),
    );
  }
}
