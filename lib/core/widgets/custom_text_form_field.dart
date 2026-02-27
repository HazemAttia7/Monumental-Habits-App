import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/show_password_text.dart';

class CustomTextFormField extends StatefulWidget {
  final IconData? prefixIcon;
  final String hintText;
  final double? iconSize;
  final Color? fillColor;
  final bool isPassword;
  final String? Function(String? data)? validator;
  final void Function(String? data)? onSaved;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    required this.hintText,
    this.iconSize,
    this.fillColor,
    this.isPassword = false,
    this.validator,
    this.onSaved,
    this.contentPadding,
    this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
    _obscureText = widget.isPassword;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      focusNode: _focusNode,
      style: AppStyles.textStyle16.copyWith(
        color: _focusNode.hasFocus
            ? AppColors.secondaryColor
            : AppColors.primaryColor.withValues(alpha: .5),
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(vertical: 20.sp, horizontal: 17.sp),
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
        fillColor: widget.fillColor ?? const Color(0xffFFF6ED),
        hintText: widget.hintText,
        hintStyle: AppStyles.textStyle16.copyWith(
          fontWeight: FontWeight.w500,
          color: _focusNode.hasFocus
              ? AppColors.secondaryColor
              : AppColors.primaryColor.withValues(alpha: .5),
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                size: widget.iconSize ?? 20.sp,
                color: _focusNode.hasFocus
                    ? AppColors.secondaryColor
                    : AppColors.primaryColor.withValues(alpha: .5),
              )
            : null,
        suffix: widget.isPassword
            ? ShowHidePasswrodText(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                isObsecured: _obscureText,
              )
            : null,
        errorMaxLines: 2,
      ),
    );
  }
}
