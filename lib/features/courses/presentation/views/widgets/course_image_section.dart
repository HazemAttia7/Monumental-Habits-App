import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseImageSection extends StatelessWidget {
  const CourseImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: AssetImage(image),
      height: 166.h,
      fit: BoxFit.cover,
    );
  }
}
