import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';

class WeekDaysRow extends StatelessWidget {
  const WeekDaysRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        7,
        (index) => Expanded(
          child: Text(
            weekDaysShort[index],
            style: AppStyles.textStyle10,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
