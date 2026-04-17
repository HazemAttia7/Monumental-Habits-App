import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';

class CommentActionsRow extends StatelessWidget {
  const CommentActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomClickableText(
          text: "REPLY",
          onTap: () {
            // TODO : implement reply
          },
          textColor: Color.lerp(AppColors.primaryColor, Colors.black, .35),
          fontSize: 12.sp,
        ),
        Gap(12.w),
        CustomClickableText(
          text: "LIKE",
          onTap: () {
            // TODO : like comment
          },
          textColor: AppColors.secondaryColor,
          fontSize: 12.sp,
        ),
      ],
    );
  }
}
