import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/settings/presentation/views/widgets/setting_card.dart';
import 'package:provider/provider.dart';

class GeneralSettingsSection extends StatelessWidget {
  const GeneralSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        SettingCard(
          title: 'Notifications',
          subtitle: 'Customize notifications',
          icon: FontAwesomeIcons.solidBell,
          onTap: () => GoRouter.of(context).push(
            AppRouter.kNotificationSettings,
            extra: context.read<HabitsCubit>(),
          ),
        ),
      ],
    );
  }
}
