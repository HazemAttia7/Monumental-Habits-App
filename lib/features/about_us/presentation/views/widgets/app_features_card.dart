import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/card_header.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/feature_list_tile.dart';

class AppFeaturesCard extends StatelessWidget {
  const AppFeaturesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardHeader(text: "WHAT'S INSIDE"),
          Gap(14.h),
          const FeatureListTile(
            title: "Daily habit tracker",
            subtitle: "Visual streaks withn color-coded days",
            icon: Icons.star_outline,
          ),
          Gap(8.h),
          const FeatureListTile(
            title: "Smart reminders",
            subtitle: "Custom notifications schedule",
            icon: Icons.schedule_outlined,
          ),
          Gap(8.h),
          const FeatureListTile(
            title: "Community",
            subtitle: "Connect and grow with like-minded people",
            icon: Icons.people_outline,
          ),
          Gap(8.h),
          const FeatureListTile(
            title: "Courses",
            subtitle: "Structured learning paths to build better habits",
            icon: Icons.play_lesson_outlined,
          ),
        ],
      ),
    );
  }
}
