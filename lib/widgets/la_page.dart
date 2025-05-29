import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

//  Generic page with theme applied
class LaPage extends StatelessWidget {
  final Widget body;
  const LaPage({required this.body, super.key});

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            AppStateController.useDarkMode.value
                ? AppColors.bgColorDarkMode
                : AppColors.bgColorLightMode,
        body: SizedBox(height: Get.height, width: Get.width, child: body),
      ),
    );
  }
}
