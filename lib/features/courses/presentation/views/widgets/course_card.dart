import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_details_section.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_image_section.dart';

class CourseCard extends StatelessWidget {
  final String image, title;
  final VoidCallback onSave, onUnsave;
  final Duration duration;
  final int lessons;

  const CourseCard({
    super.key,
    required this.image,
    required this.title,
    required this.onSave,
    required this.onUnsave,
    required this.duration,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CourseImageSection(image: image),
        CourseDetailsSection(
          title: title,
          duration: duration,
          lessons: lessons,
          onSave: onSave,
          onUnsave: onUnsave,
        ),
      ],
    );
  }
}
