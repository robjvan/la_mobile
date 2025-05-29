import 'package:flutter/material.dart';

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
        Text(label, style: TextStyle()),
        Checkbox(value: condition, onChanged: onChanged),
      ],
    );
  }
}
