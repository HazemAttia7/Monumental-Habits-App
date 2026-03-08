import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/delete_dialog.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/on_off_grid_view_item.dart';
import 'package:provider/provider.dart';

class RemovableOnOffGridViewItem extends StatelessWidget {
  final bool isOn;
  final String unit;
  final Function(bool) onTap;
  const RemovableOnOffGridViewItem({
    super.key,
    required this.isOn,
    required this.unit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12.r),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (dialogContext) => ChangeNotifierProvider.value(
              value: context.read<AddEditHabitController>(),
              child: DeleteDialog(unit: unit),
            ),
          );
        },
        child: OnOffGridViewItem(day: unit, isOn: isOn, onTap: onTap),
      ),
    );
  }
}
