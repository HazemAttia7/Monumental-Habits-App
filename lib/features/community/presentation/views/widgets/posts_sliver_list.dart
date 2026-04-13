import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_card.dart';

class PostsSliverList extends StatelessWidget {
  final List<Post> posts;
  const PostsSliverList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? SliverFillRemaining(
            child: Center(
              child: Text("No posts found !", style: AppStyles.textStyle17),
            ),
          )
        : SliverList.separated(
            itemCount: posts.length,
            separatorBuilder: (context, index) => Gap(12.h),
            itemBuilder: (BuildContext context, int index) =>
                PostCard(post: posts[index]),
          );
  }
}
