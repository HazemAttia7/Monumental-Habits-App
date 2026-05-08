import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/widgets/custom_divider.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/post_action_button_shimmer.dart';

class PostActionRowShimmer extends StatelessWidget {
  const PostActionRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Expanded(
            child: PostActionButtonShimmer(
              text: 'Like',
              icon: FontAwesomeIcons.heart,
            ),
          ),
          CustomDivider(
            width: 3.w,
            height: 40.h,
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(9999.r),
            margin: 0,
          ),
          const Expanded(
            child: PostActionButtonShimmer(
              text: 'Share',
              icon: Icons.share_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
