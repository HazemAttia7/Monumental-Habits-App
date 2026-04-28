import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/edit_delete_options.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

class CommentCardHeader extends StatelessWidget {
  final Comment comment;
  const CommentCardHeader({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final currentUserUid = context.read<AuthCubit>().currentUser!.uid;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _getAuthorName(context, currentUserUid: currentUserUid),
          style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
        ),
        if (comment.authorUid == currentUserUid)
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            child: InkWell(
              onTap: () => showPopover(
                context: context,
                bodyBuilder: (context) =>
                    EitDeleteOptions(onEditTap: () {}, onDeleteTap: () {}),
                width: 150.w,
                height: 80.h,
                backgroundColor: AppColors.scaffoldColor,
                direction: PopoverDirection.bottom,
              ),
              borderRadius: BorderRadius.circular(12.r),
              splashColor: AppColors.primaryColor.withValues(alpha: .1),
              highlightColor: AppColors.primaryColor.withValues(alpha: .1),
              child: Icon(
                FontAwesomeIcons.ellipsisVertical,
                color: AppColors.secondaryColor,
                size: 16.sp,
              ),
            ),
          ),
      ],
    );
  }

  String _getAuthorName(
    BuildContext context, {
    required String currentUserUid,
  }) {
    if (comment.authorUid == currentUserUid) return 'You';
    return comment.authorUsername;
  }
}
