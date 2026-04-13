import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_card.dart';

class PostsSliverList extends StatelessWidget {
  const PostsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 5,
      separatorBuilder: (context, index) => Gap(12.h),
      itemBuilder: (BuildContext context, int index) => const PostCard(
        userName: 'Jerome',
        content:
            "Man, you're my new guru! Viewing the lessons for a second time. Thoroughly pleased. And impressed that you draw from scientific literature in telling memorable Man, you're my new guru! Viewing the lessons for a second time. Thoroughly pleased. And impressed that you draw from scientific literature in telling memorable",
        postedSince: Duration(hours: 24),
        commentsCount: 22,
        postLikesCount: 3200,
      ),
    );
  }
}
