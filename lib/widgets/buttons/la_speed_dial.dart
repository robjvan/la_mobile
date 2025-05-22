import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/dialogs/settings.dialog.dart';

class LaSpeedDial extends StatelessWidget {
  const LaSpeedDial({super.key});

  @override
  Widget build(final BuildContext context) {
    SpeedDialChild buildSpeedDialChild(
      final Icon icon,
      final String label,
      final Function() action,
    ) {
      return SpeedDialChild(
        foregroundColor:
            AppStateController.useDarkMode.value
                ? AppColors.textColorDarkMode
                : AppColors.textColorLightMode,
        backgroundColor:
            AppStateController.useDarkMode.value
                ? const Color.fromARGB(255, 40, 40, 40)
                : AppColors.bgColorLightMode,
        child: icon,
        onTap: action,
        label: label,
        labelBackgroundColor:
            AppStateController.useDarkMode.value
                ? const Color.fromARGB(255, 40, 40, 40)
                : AppColors.bgColorLightMode,
        labelStyle: TextStyle(
          color:
              AppStateController.useDarkMode.value
                  ? AppColors.textColorDarkMode
                  : AppColors.textColorLightMode,
        ),
      );
    }

    return Obx(
      () => SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        spacing: 8.0,
        // label: Text('Menu'),
        foregroundColor:
            AppStateController.useDarkMode.value
                ? AppColors.textColorDarkMode
                : AppColors.textColorLightMode,
        backgroundColor:
            AppStateController.useDarkMode.value
                ? const Color.fromARGB(255, 40, 40, 40)
                : AppColors.bgColorLightMode,
        overlayColor:
            AppStateController.useDarkMode.value ? Colors.black : Colors.white,
        overlayOpacity: 0.5,
        activeBackgroundColor:
            AppStateController.useDarkMode.value
                ? const Color.fromARGB(255, 40, 40, 40)
                : AppColors.lightGrey,
        activeLabel: Text('Close'),
        children: <SpeedDialChild>[
          buildSpeedDialChild(
            Icon(Icons.settings, color: Colors.blueGrey),
            'Settings',
            () {
              Get.dialog(SettingsDialog());
            },
          ),
          buildSpeedDialChild(
            Icon(Icons.add, color: AppColors.green),
            'Add new plant',
            () {},
          ),
          buildSpeedDialChild(
            Icon(Icons.water_drop, color: AppColors.lightBlue),
            'Record watering',
            () {},
          ),
          buildSpeedDialChild(
            Icon(Icons.grain, color: Colors.brown),
            'Record fertilizing',
            () {},
          ),
          buildSpeedDialChild(
            Icon(Icons.insights, color: Colors.orange),
            'View Insights',
            () {},
          ),
        ],
      ),
    );
  }
}
