import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController usernameController;
  const UsernameField({required this.usernameController, super.key});

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => TextFormField(
        enabled: !AppStateController.isLoading.value,
        controller: usernameController,
        style: TextStyle(
          color:
              AppStateController.isLoading.value
                  ? AppColors.lightGrey
                  : AppTheme.textColor(),
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
            return 'login.username-error'.tr;
          } else if (!value.isEmail) {
            return 'login.invalid-username'.tr;
          }
          return null;
        },
      ),
    );
  }
}
