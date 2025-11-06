import 'package:flutter/cupertino.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class GradientLoginBackground extends StatelessWidget {
  const GradientLoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.scaffoldColor.withAlpha(0),
            AppColors.scaffoldColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.23, 0.42],
        ),
      ),
    );
  }
}
