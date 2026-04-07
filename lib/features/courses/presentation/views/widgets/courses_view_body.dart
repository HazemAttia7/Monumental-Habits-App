import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_header_section.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sliver_list.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sort_filter_row.dart';

class CoursesViewBody extends StatelessWidget {
  const CoursesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      Course(
        image: AssetsData.coursePlaceholder,
        title:
            "30 Day Journal Challenge - Establish a Habit of Daily Journaling",
        duration: const Duration(hours: 2, minutes: 41),
        lessons: 37,
      ),
      Course(
        image: AssetsData.coursePlaceholder,
        title: "Build Consistency - Master Your Daily Habits Step by Step",
        duration: const Duration(hours: 1, minutes: 55),
        lessons: 24,
      ),
      Course(
        image: AssetsData.coursePlaceholder,
        title: "Deep Focus System - Eliminate Distractions and Get More Done",
        duration: const Duration(hours: 3, minutes: 10),
        lessons: 42,
      ),
      Course(
        image: AssetsData.coursePlaceholder,
        title: "Morning Routine Blueprint - Start Your Day with Energy",
        duration: const Duration(hours: 1, minutes: 20),
        lessons: 18,
      ),
      Course(
        image: AssetsData.coursePlaceholder,
        title: "Goal Setting Mastery - Turn Your Vision into Actionable Steps",
        duration: const Duration(hours: 2, minutes: 5),
        lessons: 29,
      ),
      Course(
        image: AssetsData.coursePlaceholder,
        title: "Productivity Hacks - Work Smarter Not Harder Everyday",
        duration: const Duration(hours: 1, minutes: 45),
        lessons: 21,
      ),
      Course(
        image: AssetsData.coursePlaceholder,
        title: "Habit Tracking System - Build and Maintain Strong Habits",
        duration: const Duration(hours: 2, minutes: 30),
        lessons: 33,
      ),
    ];
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
                  const CoursesHeaderSection(),
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
