import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Obx(
          () => Scaffold(
            backgroundColor:
                AppStateController.useDarkMode.value
                    ? AppColors.bgColorDarkMode
                    : AppColors.bgColorLightMode,
            body: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Text(
                      'settings'.tr,
                      style: TextStyle(fontSize: 40.0, color: AppColors.green),
                    ),
                  ),
                  LaButton(
                    action: AppStateController.toggleDarkMode,
                    label: 'Toggle theme',
                  ),
                  Spacer(),
                  LaButton(action: UserStateController.logout, label: 'Logout'),
                  const SizedBox(height: 32.0),
                  LaButton(action: Get.back, label: 'Close'),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
