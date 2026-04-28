import 'package:flutter/cupertino.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/three_dots.dart';
import 'package:provider/provider.dart';

class ReplyCardHeader extends StatelessWidget {
  final Reply reply;
  const ReplyCardHeader({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          reply.authorUsername,
          style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
        ),
        if (reply.authorUid == context.read<AuthCubit>().currentUser!.uid)
          ThreeDots(
            onEditTap: () {
              // TODO : edit reply
            },
            onDeleteTap: () {
              // TODO : delete reply
            },
          ),
      ],
    );
  }
}
