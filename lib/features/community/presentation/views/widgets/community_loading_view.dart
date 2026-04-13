import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/view_header.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/posts_list_shimmer.dart';

class CommunityLoadingView extends StatelessWidget {
  const CommunityLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: SingleChildScrollView(
          physics:  const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Gap(10.h),
              const ViewHeader(header: "Community"),
              Gap(36.h),
              const PostsListShimmer(),
              Gap(100.h),
            ],
          ),
        ),
      ),
    );
  }
}
