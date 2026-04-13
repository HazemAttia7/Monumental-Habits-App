import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_cubit/community_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_card.dart';

class PostsSliverList extends StatelessWidget {
  const PostsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        if (state is CommunityLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CommunityError) {
          return SliverFillRemaining(
            child: Center(child: Text(state.errMessage)),
          );
        }

        if (state is CommunityLoaded) {
          final posts = state.posts;
          return SliverList.separated(
            itemCount: posts.length,
            separatorBuilder: (context, index) => Gap(12.h),
            itemBuilder: (BuildContext context, int index) => PostCard(
              userName: posts[index].authorUsername,
              content: posts[index].content,
              postedSince: _getDuration(posts[index].createdAt),
              commentsCount: posts[index].commentsCount,
              postLikesCount: posts[index].likedByUids.length,
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }

  Duration _getDuration(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    if (difference.inDays > 0) {
      return Duration(days: difference.inDays);
    } else if (difference.inHours > 0) {
      return Duration(hours: difference.inHours);
    } else if (difference.inMinutes > 0) {
      return Duration(minutes: difference.inMinutes);
    } else {
      return Duration(seconds: difference.inSeconds);
    }
  }
}
