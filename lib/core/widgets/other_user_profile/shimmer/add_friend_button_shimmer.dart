import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:shimmer/shimmer.dart';

class AddFriendButtonShimmer extends StatelessWidget {
  const AddFriendButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white.withValues(alpha: .8),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: Text(
          "ADD FRIEND",
          style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
