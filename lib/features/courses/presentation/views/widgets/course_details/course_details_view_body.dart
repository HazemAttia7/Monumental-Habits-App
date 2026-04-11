import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_details/course_video.dart';

class CourseDetailsViewBody extends StatelessWidget {
  final Course course;
  const CourseDetailsViewBody({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          children: [
            Gap(10.h),
            DefaultViewHeader(title: course.title),
            Gap(32.h),
            CourseVideo(imageUrl: course.imageUrl),
          ],
        ),
      ),
    );
  }
}
