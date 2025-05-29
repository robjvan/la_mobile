import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class LaDatePicker extends StatelessWidget {
  final String label;
  final dynamic variable;
  final bool condition;
  final Function() onPressed;
  const LaDatePicker({
    required this.label,
    required this.variable,
    required this.condition,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color:
                condition
                    ? AppStateController.useDarkMode.value
                        ? AppColors.textColorDarkMode
                        : AppColors.textColorLightMode
                    : AppColors.lightGrey,
            fontStyle: condition ? FontStyle.normal : FontStyle.italic,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: condition ? () => onPressed() : null,
          child: Text(
            variable != null
                ? variable.toString().split(' ')[0]
                : 'choose-date'.tr,
          ),
        ),
      ],
    );
  }
}
