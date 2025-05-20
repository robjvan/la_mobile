import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/settings.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class RememberUsernameButton extends StatefulWidget {
  const RememberUsernameButton({super.key});

  @override
  State<RememberUsernameButton> createState() => _RememberUsernameButtonState();
}

class _RememberUsernameButtonState extends State<RememberUsernameButton> {
  bool rememberUsername = false;

  @override
  void initState() {
    super.initState();

    // Check local storage for rememberUsername value, and if true, also load username
  }

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Obx(
            () => Text(
              'Rembember username?',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color:
                    SettingsController.useDarkMode.value
                        ? AppColors.textColorDarkMode
                        : AppColors.textColorLightMode,
              ),
            ),
          ),
          Checkbox(
            value: rememberUsername,
            onChanged: (final bool? value) {
              setState(() {
                rememberUsername = !rememberUsername;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            activeColor: AppColors.green,
            side: BorderSide(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
