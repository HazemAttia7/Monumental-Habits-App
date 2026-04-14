import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class PostInteractionsAvatars extends StatelessWidget {
  final String? firstInitial;
  final String? secondInitial;
  const PostInteractionsAvatars({
    super.key,
    this.firstInitial,
    this.secondInitial,
  });

  @override
  Widget build(BuildContext context) {
    final displayList = _getDisplayList(firstInitial, secondInitial);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (displayList.isNotEmpty)
          SizedBox(
            height: 30.h,
            child: Row(
              children: [
                ...List.generate(displayList.length, (i) {
                  return Transform.translate(
                    offset: Offset(i * -10.w, 0),
                    child: _Avatar(initials: displayList[i], index: i),
                  );
                }),
                Transform.translate(
                  offset: Offset(displayList.length * -10.w, 0),
                  child: const _HeartIcon(),
                ),
              ],
            ),
          )
        else
          const _HeartIcon(),
      ],
    );
  }

  List<String> _getDisplayList(String? firstInitial, String? secondInitial) {
    if (firstInitial != null && secondInitial != null) {
      return [firstInitial, secondInitial];
    } else if (firstInitial != null) {
      return [firstInitial];
    } else if (secondInitial != null) {
      return [secondInitial];
    } else {
      return [];
    }
  }
}

class _Avatar extends StatelessWidget {
  final int index;
  final String initials;

  const _Avatar({required this.initials, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getColor(),
        border: Border.all(color: Colors.white, width: 3.sp),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getColor() {
    if (index == 0) {
      return AppColors.fog;
    } else {
      return AppColors.twilight;
    }
  }
}

class _HeartIcon extends StatelessWidget {
  const _HeartIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
        border: Border.all(color: Colors.white, width: 3.sp),
      ),
      child: Icon(Icons.favorite, color: Colors.white, size: 14.sp),
    );
  }
}
