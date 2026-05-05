import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_view_controller.dart';
import 'package:provider/provider.dart';

class EditActionsRow extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onConfirm;
  const EditActionsRow({
    super.key,
    required this.onConfirm,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AbsorbPointer(
          absorbing: isLoading,
          child: CustomButton(
            height: 30.h,
            width: 80.w,
            fontSize: 12.sp,
            text: isLoading ? "Editing..." : "Edit",
            onTap: onConfirm,
          ),
        ),
        CustomClickableText(
          fontSize: 12.sp,
          text: "Cancel",
          textColor: AppColors.secondaryColor,
          onTap: () {
            final controller = context.read<CommunityViewController>();

            if (controller.isEditCommentMode) {
              controller.onDoneEditComment();
            } else if (controller.isEditReplyMode) {
              controller.onDoneEditReply();
            }
          },
        ),
      ],
    );
  }
}
