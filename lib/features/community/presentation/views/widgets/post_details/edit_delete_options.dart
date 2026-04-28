import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/option_widget.dart';

class EitDeleteOptions extends StatelessWidget {
  final VoidCallback onEditTap, onDeleteTap;
  const EitDeleteOptions({
    super.key,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OptionWidget(text: "Edit", onTap: onEditTap),
        OptionWidget(
          text: "Delete",
          onTap: onDeleteTap,
          backColor: Color.lerp(AppColors.primaryColor, Colors.white, 0.8),
        ),
      ],
    );
  }
}
