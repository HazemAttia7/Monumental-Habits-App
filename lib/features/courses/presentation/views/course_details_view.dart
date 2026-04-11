import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_details/course_details_view_body.dart';

class CourseDetailsView extends StatelessWidget {
  final Course course;
  const CourseDetailsView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CourseDetailsViewBody(course: course));
  }
}
