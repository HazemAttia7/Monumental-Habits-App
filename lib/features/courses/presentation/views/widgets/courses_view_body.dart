import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
        imageUrl:
            "https://i.pinimg.com/736x/36/a2/92/36a292343e7c92af591d21e4c57984b0.jpg",
        title:
            "30 Day Journal Challenge - Establish a Habit of Daily Journaling",
        duration: const Duration(hours: 2, minutes: 41),
        lessons: 37,
      ),
      Course(
        imageUrl:
            "https://i.pinimg.com/736x/7e/3c/34/7e3c34345e51a93ce3d0f7facd8d4bf3.jpg",
        title: "Build Consistency - Master Your Daily Habits Step by Step",
        duration: const Duration(hours: 1, minutes: 55),
        lessons: 24,
      ),
      Course(
        imageUrl:
            "https://i.pinimg.com/736x/b0/e7/93/b0e793224169bd4cd045b1fdcd5f7c3f.jpg",
        title: "Deep Focus System - Eliminate Distractions and Get More Done",
        duration: const Duration(hours: 3, minutes: 10),
        lessons: 42,
      ),
      Course(
        imageUrl:
            "https://i.pinimg.com/736x/04/ee/42/04ee42fb17268f404f05c5c5ae016ade.jpg",
        title: "Morning Routine Blueprint - Start Your Day with Energy",
        duration: const Duration(hours: 1, minutes: 20),
        lessons: 18,
      ),
      Course(
        imageUrl:
            "https://owlcation.com/.image/MjAyNDI3NDYwMDMyMTQ0NDUy/marriage-in-emily-dickinsons-poetry.jpg?io=1&profile=w828&x=0&y=0",
        title: "Goal Setting Mastery - Turn Your Vision into Actionable Steps",
        duration: const Duration(hours: 2, minutes: 5),
        lessons: 29,
      ),
      Course(
        imageUrl:
            "https://www.thepositivepsychologypeople.com/wp-content/uploads/2015/08/Braco-Blog.jpg",
        title: "Productivity Hacks - Work Smarter Not Harder Everyday",
        duration: const Duration(hours: 1, minutes: 45),
        lessons: 21,
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
