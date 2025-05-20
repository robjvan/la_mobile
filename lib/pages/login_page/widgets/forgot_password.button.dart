import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/settings.controller.dart';
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
          TextButton(
            onPressed: () {
              print('forgot pass fired');
              // TODO(RV): Add logic to start forgot password workflow
            },

            style: ButtonStyle(
              shape: WidgetStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              overlayColor: WidgetStatePropertyAll<Color>(
                AppColors.green.withAlpha(20),
              ),
            ),
            child: Obx(
              () => Text(
                'Forgot password?',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color:
                      SettingsController.useDarkMode.value
                          ? AppColors.textColorDarkMode
                          : AppColors.textColorLightMode,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
