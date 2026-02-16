import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/bottom_nav_bar_clipper.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/bottom_nav_bar_items_row.dart';

class CustomBottomNavBar extends StatefulWidget {
  final void Function(int selectedIndex) changePage;
  const CustomBottomNavBar({super.key, required this.changePage});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0;

  void selectItem(int index) {
    setState(() {
      widget.changePage(index);
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
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
    );
  }
}
