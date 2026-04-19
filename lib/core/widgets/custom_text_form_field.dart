import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/show_password_text.dart';

class CustomTextFormField extends StatefulWidget {
  final IconData? prefixIcon;
  final String hintText;
  final double? iconSize, fontSize;
  final FontWeight? fontWeight;
  final Color? fillColor, textColor;
  final bool isPassword, autofocus;
  final String? Function(String? data)? validator;
  final void Function(String? data)? onSaved;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String data)? onChanged;
  final bool? isDense;
  final int? maxLines;
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
    this.focusNode,
    this.onChanged,
    this.autofocus = false,
    this.isDense,
    this.textColor,
    this.maxLines = 1,
    this.fontSize,
    this.fontWeight,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });
    _obscureText = widget.isPassword;
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: _obscureText,
      focusNode: _focusNode,
      style: TextStyle(
        fontSize: widget.fontSize ?? 16.sp,
        fontWeight: widget.fontWeight ?? FontWeight.bold,
        color:
            widget.textColor ??
            (_focusNode.hasFocus
                ? AppColors.primaryColor
                : AppColors.secondaryColor.withValues(alpha: .5)),
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        isDense: widget.isDense,
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
              ? AppColors.primaryColor
              : AppColors.secondaryColor.withValues(alpha: .5),
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                size: widget.iconSize ?? 20.sp,
                color: _focusNode.hasFocus
                    ? AppColors.primaryColor
                    : AppColors.secondaryColor.withValues(alpha: .5),
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
