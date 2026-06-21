import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/notification_settings/notification_settings_view_body.dart';

class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(Colors.white, AppColors.secondaryColor, 0.08),
      body: const NotificationSettingsViewBody(),
    );
  }
}
