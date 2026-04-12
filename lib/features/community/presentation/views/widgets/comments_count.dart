import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/helper/format_count.dart';

class CommentsCount extends StatelessWidget {
  final int commentsCount;
  const CommentsCount({super.key, required this.commentsCount});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(2.r),
      child: InkWell(
        onTap: () {
          // TODO : navigate to comments view
        },
        borderRadius: BorderRadius.circular(2.r),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.w,
          children: [
            Icon(
              FontAwesomeIcons.solidComment,
              size: 17.sp,
              color: AppColors.primaryColor.withValues(alpha: .7),
            ),
            Text(
              formatCount(commentsCount),
              style: AppStyles.textStyle12.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor.withValues(alpha: .7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
