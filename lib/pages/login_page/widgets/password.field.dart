import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordField({required this.passwordController, super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool passwordObscured = true;

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: widget.passwordController,
        style: TextStyle(
          color:
              AppStateController.useDarkMode.value
                  ? AppColors.textColorDarkMode
                  : AppColors.textColorLightMode,
        ),
        decoration: InputDecoration(
          hintText: 'password'.tr,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          hintStyle: TextStyle(color: AppColors.grey),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => passwordObscured = !passwordObscured),
            child: Icon(
              passwordObscured ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.green, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        obscureText: passwordObscured,
        validator: (final String? value) {
          if (value == null || value == '') {
            return 'Password cannot be empty'.tr; // TODO(RV): Add i18n strings
          } else if (value.length < 6) {
            return 'Password must at least 6 digits'
                .tr; // TODO(RV): Add i18n strings
          }
          return null;
        },
      ),
    );
  }
}
