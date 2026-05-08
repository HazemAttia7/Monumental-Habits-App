import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/interactions_info_row_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/post_actions_row_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/post_section_header_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/post_content_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class PostSectionShimmer extends StatelessWidget {
  const PostSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            Gap(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: const PostSectionHeaderShimmer(),
            ),
            Gap(24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: const PostContentShimmer(),
            ),
            Gap(18.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: const InteractionsInfoRowShimmer(),
            ),
            Gap(8.h),
            Divider(
              color: AppColors.secondaryColor.withValues(alpha: .3),
              thickness: 1.sp,
              height: 1,
            ),
            const PostActionRowShimmer(),
          ],
        ),
      ),
    );
  }
}
