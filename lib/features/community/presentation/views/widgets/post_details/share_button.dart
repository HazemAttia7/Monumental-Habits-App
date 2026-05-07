import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final Post post;
  const ShareButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.r)),
      child: InkWell(
        onTap: () {
          final link =
              'https://hazemattia7.github.io/monument-links/post/${post.id}';
          SharePlus.instance.share(
            ShareParams(
              text: 'Check out this post by ${post.authorUsername}!\n$link',
              subject: 'Post on Monumental Habits',
            ),
          );
        },
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.r)),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: Center(child: Icon(Icons.share_outlined, size: 24.sp)),
        ),
      ),
    );
  }
}
