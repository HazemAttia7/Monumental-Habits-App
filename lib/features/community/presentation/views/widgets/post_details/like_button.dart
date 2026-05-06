import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/posts_cubit/posts_cubit.dart';

class LikeButton extends StatefulWidget {
  final Post post;
  const LikeButton({super.key, required this.post});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.likedByUids.contains(
      BlocProvider.of<AuthCubit>(context).currentUser!.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.r)),
      child: InkWell(
        onTap: () {
          setState(() {
            _isLiked = !_isLiked;
          });
          context.read<PostsCubit>().toggleLike(
            widget.post.id,
            BlocProvider.of<AuthCubit>(context).currentUser!.uid,
          );
        },
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.r)),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: Row(
              key: ValueKey(_isLiked),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isLiked
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: _isLiked
                      ? AppColors.primaryColor
                      : AppColors.secondaryColor,
                  size: 20.sp,
                ),
                Gap(4.w),
                Text(
                  _isLiked ? "Liked !" : "Like",
                  style: AppStyles.textStyle16.copyWith(
                    color: _isLiked
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
