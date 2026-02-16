import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_suggestions_button.dart';

class HabitNameInput extends StatelessWidget {
  const HabitNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      children: [
        Expanded(
          child: CustomTextFormField(
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 20.w,
            ),
            hintText: "Enter habit name",
            fillColor: Colors.white,
          ),
        ),
        const HabitSuggestionsButton(),
      ],
    );
  }
}
