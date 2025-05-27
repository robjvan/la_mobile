import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class NotesField extends StatelessWidget {
  final TextEditingController controller;
  final List<String> list;
  // final validator;
  // final hintText;
  const NotesField({required this.controller, required this.list, super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'notes'.tr,
          style: TextStyle(
            fontSize: 24.0,
            color:
                AppStateController.useDarkMode.value
                    ? AppColors.textColorDarkMode
                    : AppColors.textColorLightMode,
          ),
        ),
        TextFormField(
          controller: controller,
          style: TextStyle(
            color:
                AppStateController.useDarkMode.value
                    ? AppColors.textColorDarkMode
                    : AppColors.textColorLightMode,
          ),
          validator: (final dynamic val) => null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintText: 'new-plant.notes-hint'.tr,
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
