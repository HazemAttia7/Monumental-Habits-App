import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/community/presentation/managers/edit_content_controller.dart';
import 'package:provider/provider.dart';

class EditableContent extends StatelessWidget {
  const EditableContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditContentController>();

    return Form(
      key: controller.formKey,
      autovalidateMode: controller.autovalidateMode,
      child: CustomTextFormField(
        fillColor: Colors.white,
        isDense: true,
        autofocus: true,
        controller: controller.textController,
        hintText: "edit content...",
        textColor: Colors.black,
        maxLines: null,
        contentPadding: EdgeInsets.zero,
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
        validator: (_) {
          if (controller.textController.text.trim().isEmpty) {
            return 'content cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
