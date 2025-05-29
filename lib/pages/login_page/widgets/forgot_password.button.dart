import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Obx(
            () => TextButton(
              onPressed:
                  AppStateController.isLoading.value
                      ? null
                      : () => Get.toNamed(kForgotPasswordRouteName),

              style: ButtonStyle(
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                overlayColor: WidgetStatePropertyAll<Color>(
                  AppColors.green.withAlpha(20),
                ),
              ),
              child: Obx(
                () => Text(
                  'login.forgot-password'.tr,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color:
                        AppStateController.isLoading.value
                            ? AppColors.lightGrey
                            : AppStateController.useDarkMode.value
                            ? AppColors.textColorDarkMode
                            : AppColors.textColorLightMode,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
