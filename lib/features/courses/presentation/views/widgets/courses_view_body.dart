import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/data/models/lesson_model.dart';
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
        duration: const Duration(milliseconds: 2100000),
        lessons: [
          Lesson(
            title: "Introduction to Journaling",
            duration: const Duration(milliseconds: 300000),
          ),
          Lesson(
            title: "Why Journaling Matters",
            duration: const Duration(milliseconds: 480000),
          ),
          Lesson(
            title: "Setting Up Your Journal",
            duration: const Duration(milliseconds: 600000),
          ),
          Lesson(
            title: "Daily Writing Routine",
            duration: const Duration(milliseconds: 720000),
          ),
        ],
      ),
      Course(
        imageUrl:
            "https://i.pinimg.com/736x/7e/3c/34/7e3c34345e51a93ce3d0f7facd8d4bf3.jpg",
        title: "Build Consistency - Master Your Daily Habits Step by Step",
        duration: const Duration(milliseconds: 1440000),
        lessons: [
          Lesson(
            title: "Understanding Consistency",
            duration: const Duration(milliseconds: 360000),
          ),
          Lesson(
            title: "Habit Formation Basics",
            duration: const Duration(milliseconds: 540000),
          ),
          Lesson(
            title: "Tracking Your Progress",
            duration: const Duration(milliseconds: 600000),
          ),
          Lesson(
            title: "Overcoming Slumps",
            duration: const Duration(milliseconds: 720000),
          ),
        ],
      ),
      Course(
        imageUrl:
            "https://i.pinimg.com/736x/b0/e7/93/b0e793224169bd4cd045b1fdcd5f7c3f.jpg",
        title: "Deep Focus System - Eliminate Distractions and Get More Done",
        duration: const Duration(milliseconds: 2880000),
        lessons: [
          Lesson(
            title: "What is Deep Work?",
            duration: const Duration(milliseconds: 420000),
          ),
          Lesson(
            title: "Eliminating Distractions",
            duration: const Duration(milliseconds: 720000),
          ),
          Lesson(
            title: "Focus Techniques",
            duration: const Duration(milliseconds: 900000),
          ),
          Lesson(
            title: "Environment Setup",
            duration: const Duration(milliseconds: 840000),
          ),
        ],
      ),
      Course(
        imageUrl:
            "https://i.pinimg.com/736x/04/ee/42/04ee42fb17268f404f05c5c5ae016ade.jpg",
        title: "Morning Routine Blueprint - Start Your Day with Energy",
        duration: const Duration(milliseconds: 1980000),
        lessons: [
          Lesson(
            title: "Importance of Morning Routine",
            duration: const Duration(milliseconds: 360000),
          ),
          Lesson(
            title: "Waking Up Early",
            duration: const Duration(milliseconds: 480000),
          ),
          Lesson(
            title: "Hydration & Movement",
            duration: const Duration(milliseconds: 600000),
          ),
          Lesson(
            title: "Planning Your Day",
            duration: const Duration(milliseconds: 540000),
          ),
        ],
      ),
      Course(
        imageUrl:
            "https://owlcation.com/.image/MjAyNDI3NDYwMDMyMTQ0NDUy/marriage-in-emily-dickinsons-poetry.jpg?io=1&profile=w828&x=0&y=0",
        title: "Goal Setting Mastery - Turn Your Vision into Actionable Steps",
        duration: const Duration(milliseconds: 2520000),
        lessons: [
          Lesson(
            title: "Defining Clear Goals",
            duration: const Duration(milliseconds: 480000),
          ),
          Lesson(
            title: "SMART Goals Framework",
            duration: const Duration(milliseconds: 720000),
          ),
          Lesson(
            title: "Breaking Down Goals",
            duration: const Duration(milliseconds: 600000),
          ),
          Lesson(
            title: "Execution Strategy",
            duration: const Duration(milliseconds: 720000),
          ),
        ],
      ),
      Course(
        imageUrl:
            "https://www.thepositivepsychologypeople.com/wp-content/uploads/2015/08/Braco-Blog.jpg",
        title: "Productivity Hacks - Work Smarter Not Harder Everyday",
        duration: const Duration(milliseconds: 1920000),
        lessons: [
          Lesson(
            title: "Introduction to Productivity",
            duration: const Duration(milliseconds: 300000),
          ),
          Lesson(
            title: "Time Blocking",
            duration: const Duration(milliseconds: 540000),
          ),
          Lesson(
            title: "Prioritization Techniques",
            duration: const Duration(milliseconds: 600000),
          ),
          Lesson(
            title: "Avoiding Burnout",
            duration: const Duration(milliseconds: 480000),
          ),
        ],
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
