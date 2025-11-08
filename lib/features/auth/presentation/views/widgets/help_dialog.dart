import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "What is Monumental Habits?",
              style: TextStyle(fontSize: 20.sp, fontFamily: "Klasik"),
            ),
            Gap(10.h),
            Text(
              "A Productivity App that is uniquely designed to help users build habits that lasts. ",
              style: AppStyles.textStyle16,
            ),
          ],
        ),
      ),
    );
  }
}
