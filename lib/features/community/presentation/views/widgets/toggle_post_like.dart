import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/helper/format_count.dart';

class TogglePostLike extends StatefulWidget {
  final int postLikesCount;
  final VoidCallback onTap;
  final bool isLiked;
  const TogglePostLike({
    super.key,
    required this.postLikesCount,
    required this.onTap,
    required this.isLiked,
  });

  @override
  State<TogglePostLike> createState() => _TogglePostLikeState();
}

class _TogglePostLikeState extends State<TogglePostLike> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
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
                isLiked = !isLiked;
              });
              widget.onTap();
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
          formatCount(widget.postLikesCount),
          style: AppStyles.textStyle12.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
