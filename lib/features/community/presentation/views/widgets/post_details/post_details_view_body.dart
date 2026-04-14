import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/post_section.dart';

class PostDetailsViewBody extends StatelessWidget {
  const PostDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(12.h),
              const DefaultViewHeader(title: 'Post Details'),
              Gap(18.h),
              const PostSection(),
            ],
          ),
        ),
      ),
    );
  }
}
