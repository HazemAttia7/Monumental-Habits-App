import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/core/widgets/switch_widget.dart';
import 'package:pixel_true_app/features/settings/presentation/managers/notification_settings_controller.dart';
import 'package:provider/provider.dart';

class NotificationSettingsViewBody extends StatelessWidget {
  const NotificationSettingsViewBody({super.key});

  Future<void> _pickTime(
    BuildContext context,
    NotificationSettingsController controller, {
    required bool isStart,
  }) async {
    final initial = TimeOfDay.now();
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return;

    final formatted = picked.format(context); // e.g. "11:00 PM"

    if (isStart) {
      await controller.setQuietHours(
        start: formatted,
        end: controller.settings.quietHoursEnd,
      );
    } else {
      await controller.setQuietHours(
        start: controller.settings.quietHoursStart,
        end: formatted,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NotificationSettingsController>();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          children: [
            Gap(12.h),
            const DefaultViewHeader(title: "Notification Settings"),
            Gap(12.h),
            if (controller.isInitialized) ...[
              SwitchWidget(
                text: 'Habit Reminders',
                isOn: controller.settings.masterEnabled,
                onToggle: controller.toggleMasterSwitch,
              ),
              Gap(18.h),
              SwitchWidget(
                text: 'Do Not Disturb',
                isOn: controller.settings.quietHoursEnabled,
                onToggle: controller.settings.masterEnabled
                    ? controller.toggleQuietHours
                    : (_) {},
              ),
              if (controller.settings.quietHoursEnabled) ...[
                Gap(12.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Start Time', style: AppStyles.textStyle16),
                  trailing: Text(
                    controller.settings.quietHoursStart,
                    style: AppStyles.textStyle14,
                  ),
                  onTap: () => _pickTime(context, controller, isStart: true),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('End Time', style: AppStyles.textStyle16),
                  trailing: Text(
                    controller.settings.quietHoursEnd,
                    style: AppStyles.textStyle14,
                  ),
                  onTap: () => _pickTime(context, controller, isStart: false),
                ),
              ],
              Gap(18.h),
              SwitchWidget(
                text: 'Sound',
                isOn: controller.settings.soundEnabled,
                onToggle: controller.settings.masterEnabled
                    ? controller.toggleSound
                    : (_) {},
              ),
              Gap(18.h),
              SwitchWidget(
                text: 'Vibration',
                isOn: controller.settings.vibrationEnabled,
                onToggle: controller.settings.masterEnabled
                    ? controller.toggleVibration
                    : (_) {},
              ),
            ] else
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
