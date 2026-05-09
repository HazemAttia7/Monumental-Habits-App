import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  const SectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
