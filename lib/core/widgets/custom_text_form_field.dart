import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final double? iconSize;
  const CustomTextFormField({
    super.key,
    required this.icon,
    required this.hintText,
    this.iconSize,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      style: AppStyles.textStyle16.copyWith(
        color: _focusNode.hasFocus
            ? AppColors.secondaryColor
            : AppColors.primaryColor.withValues(alpha: .5),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 20.sp,
          horizontal: 17.sp,
        ),
        prefixIcon: Icon(
          widget.icon,
          size: widget.iconSize ?? 20.sp,
          color: _focusNode.hasFocus
              ? AppColors.secondaryColor
              : AppColors.primaryColor.withValues(alpha: .5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xffFFF6ED),
        hintText: widget.hintText,
        hintStyle: AppStyles.textStyle16.copyWith(
          fontWeight: FontWeight.w500,
          color: _focusNode.hasFocus
              ? AppColors.secondaryColor
              : AppColors.primaryColor.withValues(alpha: .5),
        ),
      ),
    );
  }
}
