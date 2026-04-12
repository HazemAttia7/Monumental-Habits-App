import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class PostContent extends StatelessWidget {
  final String content;
  const PostContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        content,
        style: AppStyles.textStyle14,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
