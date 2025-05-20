import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/settings.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class LaButton extends StatelessWidget {
  final Function() action;
  final String label;
  const LaButton({required this.action, required this.label, super.key});

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: action,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: AppColors.green, width: 1),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll<Color>(
            SettingsController.useDarkMode.value
                ? const Color.fromRGBO(40, 40, 40, 1)
                : AppColors.bgColorLightMode,
          ),
          foregroundColor: WidgetStatePropertyAll<Color>(
            SettingsController.useDarkMode.value
                ? AppColors.textColorDarkMode
                : AppColors.green,
          ),
          overlayColor: WidgetStatePropertyAll<Color>(
            AppColors.green.withAlpha(80),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
