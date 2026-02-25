import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/animated_off_on_button.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key});

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  bool _isOn = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Notification",
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
          ),
          AnimatedOffOnButton(
            onTap: (isOn) {
              setState(() {
                _isOn = isOn;
              });
              /* TODO :
              If the toggle is ON:

              1. The app schedules a local notification.
              2. It uses the selected Reminder time (e.g., 10:00 AM).
              3. It respects the selected habit frequency days (Sun, Mon, Tue…).
              4. The user receives a push/local notification at that time.
              -------------------------------------------------------------------
              If the toggle is OFF:

              1. Cancel any previously scheduled notifications for this habit.
              2. Do NOT schedule new notifications.
              3. Reminder time can stay visible but becomes inactive logically.
              */
            },
            isOn: _isOn,
          ),
        ],
      ),
    );
  }
}
