import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';

class BadCredentialsDialog extends StatelessWidget {
  const BadCredentialsDialog({super.key});

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.backgroundColor(),
      title: Text(
        'Bad creds bro',
        style: TextStyle(color: AppTheme.textColor()),
      ),
      content: Text(
        "Nuh uh uh you didn't say the magic word",
        style: TextStyle(color: AppTheme.textColor()),
      ),
      actions: <Widget>[LaButton(action: Get.back, label: 'Ok')],
    );
  }
}
