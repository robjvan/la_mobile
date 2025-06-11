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
        enabled: !AppStateController.isLoading.value,
        controller: widget.passwordController,
        style: TextStyle(
          color:
              AppStateController.isLoading.value
                  ? AppColors.lightGrey
                  : AppTheme.textColor(),
        ),
        decoration: InputDecoration(
          hintText: 'password'.tr,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          hintStyle: TextStyle(color: AppColors.grey),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => passwordObscured = !passwordObscured),
            child: Icon(
              passwordObscured ? Icons.visibility_off : Icons.visibility,
              color:
                  AppStateController.isLoading.value
                      ? AppColors.lightGrey
                      : AppColors.grey,
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
            return 'login.password-error'.tr;
          } else if (value.length < 6) {
            return 'login.password-too-short'.tr;
          }
          return null;
        },
      ),
    );
  }
}
