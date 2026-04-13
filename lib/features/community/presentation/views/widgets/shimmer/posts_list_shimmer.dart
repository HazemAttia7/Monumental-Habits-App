import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/post_card_shimmer.dart';

class PostsListShimmer extends StatelessWidget {
  const PostsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (context, index) => Gap(12.h),
      itemBuilder: (BuildContext context, int index) => const PostCardShimmer(),
    );
  }
}
