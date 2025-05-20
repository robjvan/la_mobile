import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/settings.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController usernameController;
  const UsernameField({required this.usernameController, super.key});

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: usernameController,
        style: TextStyle(
          color:
              SettingsController.useDarkMode.value
                  ? AppColors.textColorDarkMode
                  : AppColors.textColorLightMode,
        ),
        decoration: InputDecoration(
          hintText: 'username'.tr,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          hintStyle: TextStyle(color: AppColors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
            borderRadius: BorderRadius.circular(16),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.green, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        validator: (final String? value) {
          if (value == null || value == '') {
            return 'Username cannot be empty';
          } else if (!value.isEmail) {
            return 'Username must be a valid email address';
          }
          return null;
        },
      ),
    );
  }
}
