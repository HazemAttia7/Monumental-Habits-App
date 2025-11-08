import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/custom_list_tile.dart';

class SignInWithButton extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onTap;
  const SignInWithButton({super.key, required this.text, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: CustomListTile(
          mainAxisAlignment: MainAxisAlignment.center,
          leftPadding: 0,
          leadingImage: image,
          title: text,
          spacing: 16.w,
        ),
      ),
    );
  }
}
