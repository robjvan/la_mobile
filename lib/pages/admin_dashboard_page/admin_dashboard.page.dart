import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            AppStateController.useDarkMode.value
                ? AppColors.bgColorDarkMode
                : AppColors.bgColorLightMode,
        body: Placeholder(),
      ),
    );
  }
}
