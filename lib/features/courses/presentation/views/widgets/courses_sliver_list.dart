import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_card.dart';

class CoursesSliverList extends StatelessWidget {
  const CoursesSliverList({super.key, required this.courses});

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) => CourseCard(
        onTap: () {
          // TODO : navigate to course details
        },
        onSave: () {
          // TODO : add courses[index] to favourites
        },
        onUnsave: () {
          // TODO : remove courses[index] from favourites
        },
        course: courses[index],
      ),
      separatorBuilder: (BuildContext context, int index) => Gap(12.h),
    );
  }
}
