import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/custom_bottom_nav_bar_item.dart';

class BottomNavBarItemsRow extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) selectItem;
  const BottomNavBarItemsRow({
    super.key,
    required this.selectedIndex,
    required this.selectItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.sp,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            CustomBottomNavBarItem(
              image: AssetsData.home,
              isSelected: selectedIndex == 0,
              onTap: () => selectItem(0),
            ),
            CustomBottomNavBarItem(
              image: AssetsData.courses,
              isSelected: selectedIndex == 1,
              onTap: () => selectItem(1),
            ),
            SizedBox(width: 50.sp),
            CustomBottomNavBarItem(
              image: AssetsData.community,
              isSelected: selectedIndex == 2,
              onTap: () => selectItem(2),
            ),
            CustomBottomNavBarItem(
              image: AssetsData.settings,
              isSelected: selectedIndex == 3,
              onTap: () => selectItem(3),
            ),
          ],
        ),
      ),
    );
  }
}
