import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_divider.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/like_button.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/share_button.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Expanded(child: LikeButton()),
          CustomDivider(
            width: 3.w,
            height: 40.h,
            color: AppColors.secondaryColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(9999.r),
            margin: 0,
          ),
          const Expanded(child: ShareButton()),
        ],
      ),
    );
  }
}
