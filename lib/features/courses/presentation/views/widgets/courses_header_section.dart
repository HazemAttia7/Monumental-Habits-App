import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/sliding_header_container.dart';

class CoursesHeaderSection extends StatelessWidget {
  const CoursesHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SlidingHeaderContainer(),
        Gap(24.h),
        Image.asset(AssetsData.coursesCard, fit: BoxFit.cover),
      ],
    );
  }
}
