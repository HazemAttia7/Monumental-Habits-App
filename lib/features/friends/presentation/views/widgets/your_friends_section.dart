import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_list_.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/section_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

class YourFriendsSection extends StatelessWidget {
  const YourFriendsSection({super.key, required this.friends});

  final List<Friend> friends;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: SectionHeader(
            text: "YOUR FRIENDS",
            viewAll: () {
              // TODO : implement view all friends
            },
          ),
        ),
        SliverToBoxAdapter(child: Gap(16.h)),
        FriendsList(friends: friends),
      ],
    );
  }
}
