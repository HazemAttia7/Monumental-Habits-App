import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/am_pm_enums.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/am_pm_container.dart';

class AmPmToggle extends StatefulWidget {
  const AmPmToggle({super.key});

  @override
  State<AmPmToggle> createState() => _AmPmToggleState();
}

class _AmPmToggleState extends State<AmPmToggle> {
  enAmPm _selectedPeriod = enAmPm.am;

  void _toggle({required clickedPeriod}) {
    if (_selectedPeriod == clickedPeriod) return;
    setState(() {
      if (_selectedPeriod == enAmPm.am) {
        _selectedPeriod = enAmPm.pm;
      } else {
        _selectedPeriod = enAmPm.am;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AmPmContainer(
            period: 'am',
            isSelected: _selectedPeriod == enAmPm.am,
            toggle: () => _toggle(clickedPeriod: enAmPm.am),
          ),
        ),
        Expanded(
          child: AmPmContainer(
            period: "pm",
            isSelected: _selectedPeriod == enAmPm.pm,
            toggle: () => _toggle(clickedPeriod: enAmPm.pm),
          ),
        ),
      ],
    );
  }
}
