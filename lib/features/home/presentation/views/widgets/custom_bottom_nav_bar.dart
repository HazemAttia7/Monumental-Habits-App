import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/bottom_nav_bar_clipper.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/bottom_nav_bar_items_row.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/custom_floating_button.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0;

  void selectItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: BottomNavBarClipper(),
          child: Stack(
            children: [
              Container(height: 80.sp, color: Colors.white),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BottomNavBarItemsRow(
                    selectedIndex: selectedIndex,
                    selectItem: selectItem,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: -110.sp,
          child: Center(child: CustomFloatingButton(onTap: () {})),
        ),
      ],
    );
  }
}
