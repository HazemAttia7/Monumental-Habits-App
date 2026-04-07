import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_card.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_header_section.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sort_filter_row.dart';

class CoursesViewBody extends StatelessWidget {
  const CoursesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          children: [
            Gap(10.h),
            const CoursesHeaderSection(),
            Gap(16.h),
            const CoursesSortFilterRow(),
            Gap(16.h),
            CourseCard(
              image: AssetsData.coursePlaceholder,
              title:
                  "30 Day Journal Challenge - Establish a Habit of Daily Journaling",
              onSave: () {
                // TODO : add to favourites
              },
              onUnsave: () {
                // TODO : remove from favourites
              },
              duration: const Duration(hours: 2, minutes: 41),
              lessons: 37,
            ),
          ],
        ),
      ),
    );
  }
}
