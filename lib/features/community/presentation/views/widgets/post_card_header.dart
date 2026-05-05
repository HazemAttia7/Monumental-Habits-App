import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/posts_cubit/posts_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/three_dots.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/user_meta_row.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog.dart';
import 'package:provider/provider.dart';

class PostCardHeader extends StatelessWidget {
  final Post post;
  final Duration postedSince;
  const PostCardHeader({
    super.key,
    required this.post,
    required this.postedSince,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserUid = context.read<AuthCubit>().currentUser!.uid;
    return Column(
      children: [
        Row(
          children: [
            UserMetaRow(
              userName: post.authorUsername,
              postedSince: postedSince,
            ),
            const Spacer(),
            CustomIconButton(
              onTap: () {
                // TODO : share post
              },
              icon: FontAwesomeIcons.share,
              iconSize: 16.sp,
              padding: EdgeInsets.all(12.sp),
            ),
            if (post.authorUid == currentUserUid)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: ThreeDots(
                  onEditTap: () {
                    GoRouter.of(context).pop();
                    context.read<CommunityViewController>().onEditPostTap(
                      post.id,
                    );
                  },
                  onDeleteTap: () {
                    GoRouter.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (dialogContext) => DeleteDialog(
                        itemLabel: "this post",
                        onDelete: () {
                          context.read<PostsCubit>().deletePost(post);
                          GoRouter.of(context).pop();
                        },
                        headerIcon: Icons.delete,
                        collectionLabel: 'posts',
                        itemType: 'post',
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
        Gap(12.h),
        Divider(
          color: AppColors.primaryColor.withValues(alpha: .1),
          thickness: 2.w,
          height: 1,
        ),
        Gap(12.h),
      ],
    );
  }
}
