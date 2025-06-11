import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';
import 'package:la_mobile/widgets/buttons/la_cancel_button.dart';

class PhotoSourceDialog extends StatelessWidget {
  final Function() cameraAction;
  final Function() galleryAction;

  const PhotoSourceDialog({
    required this.cameraAction,
    required this.galleryAction,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.backgroundColor(),
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        'Choose image source'.tr, // TODO(RV): Add i18n strings
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LaButton(
            action: cameraAction,
            label: 'camera'.tr, // TODO(RV): Add i18n strings
          ),
          LaButton(
            action: galleryAction,
            label: 'gallery'.tr, // TODO(RV): Add i18n strings
          ),
        ],
      ),
      actions: <Widget>[LaCancelButton()],
    );
  }
}
