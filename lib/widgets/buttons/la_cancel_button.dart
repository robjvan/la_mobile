import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class LaCancelButton extends StatelessWidget {
  const LaCancelButton({super.key});

  @override
  Widget build(final BuildContext context) {
    return TextButton(
      onPressed: Get.back,
      child: Text('cancel'.tr, style: TextStyle(color: AppTheme.textColor())),
    );
  }
}
