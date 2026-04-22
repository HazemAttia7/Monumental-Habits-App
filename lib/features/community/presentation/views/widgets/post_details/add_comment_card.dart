import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';

class AddCommentCard extends StatefulWidget {
  const AddCommentCard({super.key});

  @override
  State<AddCommentCard> createState() => _AddCommentCardState();
}

class _AddCommentCardState extends State<AddCommentCard> {
  bool _isLoading = false;

  Future<void> _submitComment() async {
    setState(() => _isLoading = true);
    // Add Comment
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 1.sw - 2 * kPagePadding.w - 52.w),
      padding: EdgeInsets.only(
        top: 6.h,
        bottom: 12.sp,
        left: 12.w,
        right: 12.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You",
            style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
          CustomTextFormField(
            fillColor: Colors.white,
            hintText: "What's on your mind?",
            textColor: Colors.black,
            maxLines: null,
            contentPadding: EdgeInsets.zero,
            fontSize: 13.sp,
            fontWeight: FontWeight.normal,
          ),
          Gap(8.h),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AbsorbPointer(
              absorbing: _isLoading,
              child: CustomButton(
                height: 30.h,
                text: _isLoading ? "Commenting..." : "Comment",
                onTap: _submitComment,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
