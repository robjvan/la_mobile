import 'package:flutter/material.dart';
import 'package:la_mobile/utilities/theme.dart';

class LaReminderToggle extends StatelessWidget {
  final String label;
  final bool condition;
  final Function(bool? val) onChanged;
  const LaReminderToggle({
    required this.label,
    required this.condition,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: AppTheme.textColor(), fontSize: 18.0),
          overflow: TextOverflow.ellipsis,
        ),
        Checkbox(
          value: condition,
          onChanged: onChanged,
          activeColor: AppColors.green.withAlpha(160),
        ),
      ],
    );
  }
}
