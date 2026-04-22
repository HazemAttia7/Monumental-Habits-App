import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/add_comment_card.dart';

class AddCommentPlaceholder extends StatelessWidget {
  const AddCommentPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePlaceholder(
          userName: BlocProvider.of<AuthCubit>(context).currentUser!.name,
          padding: EdgeInsets.all(12.sp),
        ),
        Gap(8.w),
        const Expanded(child: AddCommentCard()),
      ],
    );
  }
}
