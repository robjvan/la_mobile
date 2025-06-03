import 'package:flutter/material.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class LaTextInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;

  const LaTextInputField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.validator,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: 24.0, color: AppTheme.textColor()),
        ),
        TextFormField(
          controller: controller,
          validator:
              validator ??
              (final String? val) {
                return null;
              },
          style: TextStyle(color: AppTheme.textColor()),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.green, width: 2),
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUnfocus,
        ),
      ],
    );
  }
}
