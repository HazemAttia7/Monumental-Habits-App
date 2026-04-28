import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/widgets/shimmer/line_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class CommentsShimmer extends StatelessWidget {
  const CommentsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          Icon(
            FontAwesomeIcons.solidComment,
            size: 17.sp,
            color: Colors.grey.shade300,
          ),
          LineShimmer(width: 10.w, height: 4.h),
        ],
      ),
    );
  }
}
