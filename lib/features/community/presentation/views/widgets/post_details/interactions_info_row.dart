import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/post_interactions_avatars.dart';

// TODO : make the full 'Show Interactions' view and implement the logic
class InteractionsInfoRow extends StatelessWidget {
  const InteractionsInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PostInteractionsAvatars(firstInitial: 'HA', secondInitial: 'KL'),
        LikesInfo(likesCount: 20),
      ],
    );
  }
}

class LikesInfo extends StatelessWidget {
  final int likesCount;
  const LikesInfo({super.key, required this.likesCount});

  @override
  Widget build(BuildContext context) {
    return Text(_getLikesInfo(), style: AppStyles.textStyle14);
  }

  String _getLikesInfo() {
    return likesCount == 1 ? '$likesCount like' : '$likesCount likes';
  }
}
