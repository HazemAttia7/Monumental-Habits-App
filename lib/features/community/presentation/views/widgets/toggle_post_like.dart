import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/helper/format_count.dart';

class TogglePostLike extends StatefulWidget {
  final int postLikesCount;
  final VoidCallback toggleLike;
  final bool isLiked;
  const TogglePostLike({
    super.key,
    required this.postLikesCount,
    required this.toggleLike,
    required this.isLiked,
  });

  @override
  State<TogglePostLike> createState() => _TogglePostLikeState();
}

class _TogglePostLikeState extends State<TogglePostLike> {
  late bool isLiked;
  late int likesCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likesCount = widget.postLikesCount;
  }

  @override
  void didUpdateWidget(covariant TogglePostLike oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.postLikesCount != widget.postLikesCount ||
        oldWidget.isLiked != widget.isLiked) {
      isLiked = widget.isLiked;
      likesCount = widget.postLikesCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.w,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: GestureDetector(
            key: ValueKey(isLiked),
            onTap: () {
              setState(() {
                if (isLiked) {
                  likesCount--;
                } else {
                  likesCount++;
                }
                isLiked = !isLiked;
              });
              widget.toggleLike();
            },
            child: Icon(
              isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              size: 17.sp,
              color: AppColors.primaryColor,
            ),
          ),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
        ),
        Text(
          formatCount(likesCount),
          style: AppStyles.textStyle12.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
