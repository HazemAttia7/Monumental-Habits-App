import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/edit_content_controller.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/expandable_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/editable_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_actions_row.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_card_header.dart';
import 'package:provider/provider.dart';

class ReplyCard extends StatelessWidget {
  final Reply reply;
  final Function(Reply) onReplyTap;
  const ReplyCard({super.key, required this.reply, required this.onReplyTap});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CommunityViewController>();
    return Container(
      constraints: BoxConstraints(
        maxWidth: 1.sw - 2 * kPagePadding.w - 52.w - 38.w,
      ),
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReplyCardHeader(reply: reply),
          Gap(4.h),
          Wrap(
            children: [
              if (reply.replyToUsername != null)
                Text(
                  '@${reply.replyToUsername} ',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              (reply.id == controller.replyIdToEdit &&
                      controller.isEditReplyMode)
                  ? Builder(
                      builder: (context) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final editController = context
                              .read<EditContentController>();
                          editController.setText(reply.content);
                        });

                        return const EditableContent();
                      },
                    )
                  : ExpandableContent(
                      content: reply.content,
                      style: AppStyles.textStyle14.copyWith(
                        color: Colors.black,
                      ),
                    ),
            ],
          ),
          Gap(8.h),
          ReplyActionsRow(onReplyTap: onReplyTap, reply: reply),
        ],
      ),
    );
  }
}
