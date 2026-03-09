import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';

OverlayEntry? _snackBarEntry;
Timer? _dismissTimer;

class AnimatedSnackBar extends StatefulWidget {
  final String message;
  final Color backColor;
  final IconData icon;
  const AnimatedSnackBar({
    super.key,
    required this.message,
    required this.backColor,
    required this.icon,
  });

  @override
  State<AnimatedSnackBar> createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: widget.backColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            CustomIconButton(
              padding: EdgeInsets.all(8.sp),
              onTap: () {
                _dismissTimer?.cancel();
                _dismissTimer = null;
                _snackBarEntry?.remove();
                _snackBarEntry = null;
              },
              icon: widget.icon,
              backColor: Colors.white,
              shape: BoxShape.rectangle,
            ),
            Gap(20.w),
            Expanded(
              child: Text(
                widget.message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void buildClosableSnackBar(
  BuildContext context, {
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  _dismissTimer?.cancel();
  _snackBarEntry?.remove();

  final overlay = Overlay.of(context, rootOverlay: true);

  _snackBarEntry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 20.h,
      left: 16.w,
      right: 16.w,
      child: Material(
        color: Colors.transparent,
        child: AnimatedSnackBar(
          message: message,
          backColor: AppColors.primaryColor,
          icon: Icons.close,
        ),
      ),
    ),
  );

  overlay.insert(_snackBarEntry!);

  _dismissTimer = Timer(duration, () {
    _snackBarEntry?.remove();
    _snackBarEntry = null;
    _dismissTimer = null;
  });
}

void buildSuccessSnackBar(
  BuildContext context, {
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  _dismissTimer?.cancel();
  _snackBarEntry?.remove();

  final overlay = Overlay.of(context, rootOverlay: true);

  _snackBarEntry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 20.h,
      left: 16.w,
      right: 16.w,
      child: Material(
        color: Colors.transparent,
        child: AnimatedSnackBar(
          message: message,
          backColor: const Color(0xFF2E7D32),
          icon: Icons.check,
        ),
      ),
    ),
  );

  overlay.insert(_snackBarEntry!);

  _dismissTimer = Timer(duration, () {
    _snackBarEntry?.remove();
    _snackBarEntry = null;
    _dismissTimer = null;
  });
}
