import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/settings.controller.dart';
import 'package:la_mobile/controllers/user.controller.dart';
import 'package:la_mobile/services/network.service.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/la_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            SettingsController.useDarkMode.value
                ? AppColors.bgColorDarkMode
                : AppColors.bgColorLightMode,
        body: SizedBox(
          width: Get.width,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image.asset('assets/logo/logo.png'),
                Text(
                  'home page'.tr,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(color: AppColors.green),
                ),
                const SizedBox(height: 32),
                Text(
                  'Hello ${UserController.user.value.username}',
                  style: TextStyle(
                    color:
                        SettingsController.useDarkMode.value
                            ? AppColors.textColorDarkMode
                            : AppColors.textColorLightMode,
                  ),
                ),
                Spacer(),
                LaButton(
                  action: SettingsController.toggleDarkMode,
                  label: 'Toggle theme',
                ),
                const SizedBox(height: 8),
                LaButton(action: NetworkService.logout, label: 'Logout'),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
