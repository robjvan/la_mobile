import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/services/local_storage.service.dart';
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
    if (AppStateController.saveUsername.value) {
      rememberUsername = true;
    }
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
              'login.remember-username'.tr,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color:
                    AppStateController.isLoading.value
                        ? AppColors.lightGrey
                        : AppStateController.useDarkMode.value
                        ? AppColors.textColorDarkMode
                        : AppColors.textColorLightMode,
              ),
            ),
          ),
          Obx(
            () => Checkbox(
              value: rememberUsername,
              onChanged:
                  AppStateController.isLoading.value
                      ? null
                      : (final bool? value) {
                        setState(() {
                          rememberUsername = !rememberUsername;
                        });
                        if (value!) {
                          LocalStorageService.storeSaveUsernameSetting(true);
                        } else {
                          LocalStorageService.storeSaveUsernameSetting(false);
                        }
                      },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              activeColor:
                  AppStateController.isLoading.value
                      ? AppColors.lightGrey
                      : AppColors.green,
              side: BorderSide(color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
