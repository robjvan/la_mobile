import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';

class BadCredentialsDialog extends StatelessWidget {
  const BadCredentialsDialog({super.key});

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      backgroundColor:
          AppStateController.useDarkMode.value
              ? AppColors.bgColorDarkMode
              : AppColors.bgColorLightMode,
      title: Text(
        'Bad creds bro',
        style: TextStyle(
          color:
              AppStateController.useDarkMode.value
                  ? AppColors.textColorDarkMode
                  : AppColors.textColorLightMode,
        ),
      ),
      content: Text(
        "Nuh uh uh you didn't say the magic word",
        style: TextStyle(
          color:
              AppStateController.useDarkMode.value
                  ? AppColors.textColorDarkMode
                  : AppColors.textColorLightMode,
        ),
      ),
      actions: <Widget>[LaButton(action: Get.back, label: 'Ok')],
    );
  }
}
