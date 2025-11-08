import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/custom_list_tile.dart';

class ContinueWithButton extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;
  const ContinueWithButton({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: CustomListTile(leadingImage: image, title: text),
      ),
    );
  }
}
