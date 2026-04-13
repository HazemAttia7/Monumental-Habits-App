import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/shimmer/course_card_shimmer.dart';

class CoursesListShimmer extends StatelessWidget {
  const CoursesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) => Gap(12.h),
      itemBuilder: (BuildContext context, int index) =>
          const CourseCardShimmer(),
    );
  }
}
