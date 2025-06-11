import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LaPreferenceToggle extends StatelessWidget {
  final Function(int?) onToggle;
  final String label;

  const LaPreferenceToggle({
    required this.onToggle,
    required this.label,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: AppTheme.textColor(), fontSize: 24.0),
        ),
        const SizedBox(height: 8.0),
        ToggleSwitch(
          activeBgColor: <Color>[AppColors.green.withAlpha(140)],
          inactiveBgColor: AppColors.lightGrey,
          totalSwitches: 3,
          labels: <String>['low'.tr, 'medium'.tr, 'high'.tr],
          onToggle: onToggle,
        ),
      ],
    );
  }
}
