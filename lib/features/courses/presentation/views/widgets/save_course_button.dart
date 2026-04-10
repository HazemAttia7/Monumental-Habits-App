import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class SaveCourseButton extends StatefulWidget {
  final VoidCallback? onTap;
  final bool isSaved;

  const SaveCourseButton({super.key, this.isSaved = false, this.onTap});

  @override
  State<SaveCourseButton> createState() => _SaveCourseButtonState();
}

class _SaveCourseButtonState extends State<SaveCourseButton> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isSaved;
  }

  void _toggle() {
    setState(() => _isSaved = !_isSaved);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondaryColor.withValues(alpha: .1),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        onTap: _toggle,
        child: Padding(
          padding: EdgeInsets.all(11.sp),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: Icon(
              key: ValueKey(_isSaved),
              _isSaved
                  ? FontAwesomeIcons.solidBookmark
                  : FontAwesomeIcons.bookmark,
              size: 18.sp,
              color: _isSaved
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
