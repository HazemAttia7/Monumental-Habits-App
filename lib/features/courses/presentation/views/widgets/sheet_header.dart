import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';

class SheetHeader extends StatelessWidget {
  final VoidCallback onResetTap;
  const SheetHeader({super.key, required this.onResetTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Filters", style: AppStyles.textStyle18),
        CustomClickableText(fontSize: 14.sp, text: "Reset", onTap: onResetTap),
      ],
    );
  }
}
