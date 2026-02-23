import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/main_page_enum.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/bottom_nav_bar_clipper.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/bottom_nav_bar_items_row.dart';

class CustomBottomNavBar extends StatefulWidget {
  final MainPage currentPage;
  final Function(MainPage) onPageSelected;

  const CustomBottomNavBar({
    super.key,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0;

  @override
  void didUpdateWidget(covariant CustomBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    selectedIndex = MainPage.values.indexOf(widget.currentPage);
  }

  void selectItem(int index) {
    final page = MainPage.values[index];

    setState(() {
      selectedIndex = index;
    });

    widget.onPageSelected(page);
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
