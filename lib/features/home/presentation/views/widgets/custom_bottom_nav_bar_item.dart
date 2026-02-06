import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBarItem extends StatelessWidget {
  final String image;
  final bool isSelected;
  final VoidCallback onTap;
  const CustomBottomNavBarItem({
    super.key,
    required this.image,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // Grayscale Filter
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
        builder: (context, value, child) {
          return ColorFiltered(
            colorFilter: ColorFilter.matrix(_getColorMatrix(value)),
            child: child,
          );
        },
        child: SvgPicture.asset(image),
      ),
    );
  }

  List<double> _getColorMatrix(double value) {
    // value: 0.0 = grayscale, 1.0 = full color
    return [
      0.2126 + 0.7874 * value,
      0.7152 - 0.7152 * value,
      0.0722 - 0.0722 * value,
      0,
      0,
      0.2126 - 0.2126 * value,
      0.7152 + 0.2848 * value,
      0.0722 - 0.0722 * value,
      0,
      0,
      0.2126 - 0.2126 * value,
      0.7152 - 0.7152 * value,
      0.0722 + 0.9278 * value,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ];
  }
}
