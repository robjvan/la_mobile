import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';

class ErrorDialog extends StatelessWidget {
  final String content;
  const ErrorDialog(this.content, {super.key});

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      backgroundColor:
          AppStateController.useDarkMode.value
              ? AppColors.bgColorDarkMode
              : AppColors.bgColorLightMode,
      title: Text('error'.tr, style: TextStyle(color: AppTheme.textColor())),
      content: Text(content, style: TextStyle(color: AppTheme.textColor())),
      actions: <Widget>[LaButton(label: 'ok'.tr, action: Get.back)],
    );
  }
}
