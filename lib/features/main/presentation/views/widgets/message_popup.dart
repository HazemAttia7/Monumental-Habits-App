
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/widgets/custom_circle_icon_button.dart';

class MessagePopup extends StatelessWidget {
  final VoidCallback onClose;
  const MessagePopup({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AssetsData.messagePopup,
          width: 0.92.sw,
          fit: BoxFit.contain,
        ),
        Positioned.fill(
          child: Align(
            alignment: AlignmentGeometry.topRight,
            child: Material(
              color: Colors.transparent,
              child: CustomCircleIconButton(
                onTap: onClose,
                icon: Icons.close,
                padding: EdgeInsets.all(4.sp),
                iconSize: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
