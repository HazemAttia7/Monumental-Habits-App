import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/validator.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/core/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/habit_suggestions_button.dart';
import 'package:provider/provider.dart';

class HabitNameInput extends StatelessWidget {
  final Color? themeColor;
  const HabitNameInput({super.key, this.themeColor});

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
            validator: Validator.validateHabitName,
            controller: Provider.of<AddEditHabitController>(
              context,
            ).habitNameController,
          ),
        ),
        HabitSuggestionsButton(themeColor: themeColor),
      ],
    );
  }
}
