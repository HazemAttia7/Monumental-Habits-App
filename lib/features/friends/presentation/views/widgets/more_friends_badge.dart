import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class MoreFriendsBadge extends StatelessWidget {
  final int friendsLength;
  const MoreFriendsBadge({super.key, required this.friendsLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Text(_getRequestText(), style: AppStyles.textStyle12),
      ),
    );
  }

  String _getRequestText() {
    if (friendsLength - 4 == 1) {
      return "1 more friend";
    } else {
      return "${friendsLength - 4} more friends";
    }
  }
}
