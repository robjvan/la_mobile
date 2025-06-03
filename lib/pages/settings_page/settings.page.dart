import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';
import 'package:la_mobile/widgets/dialogs/contact_us.dialog.dart';
import 'package:la_mobile/widgets/dialogs/privacy_policy.dialog.dart';
import 'package:la_mobile/widgets/dialogs/tos.dialog.dart';
import 'package:la_mobile/widgets/la_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget _buildHeaderRow() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info_outline, color: AppColors.grey),
          onPressed: () => Get.dialog(AboutDialog()),
        ),
        const Spacer(),
        Text(
          'settings'.tr,
          style: TextStyle(fontSize: 40.0, color: AppColors.green),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.email_outlined, color: AppColors.grey),
          onPressed: () => Get.dialog(ContactUsDialog()),
        ),
      ],
    );
  }

  Widget _buildDarkModeToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Obx(
              () => Text(
                'Use dark mode'.tr,
                style: TextStyle(fontSize: 16.0, color: AppTheme.textColor()),
              ),
            ),
            Spacer(),
            Obx(
              () => Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(4),
                ),
                activeColor: AppColors.green,
                value: AppStateController.useDarkMode.value,
                onChanged:
                    (final bool? value) => AppStateController.toggleDarkMode(),
              ),
            ),
          ],
        ),
        Text(
          'Aut est numquam dolorem qui quae aut.',
          style: TextStyle(color: AppColors.grey, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildBiometricsToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Use biometrics to login'.tr,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16.0,
                // AppStateController.useDarkMode.value
                //     ? AppColors.textColorDarkMode
                //     : AppColors.textColorLightMode,
              ),
            ),
            Spacer(),
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(4),
              ),
              activeColor: AppColors.green,
              value: false,
              onChanged: null,
              side: BorderSide(color: AppColors.grey),
            ),
          ],
        ),
        Text(
          'Aut est numquam dolorem qui quae aut. Non temporibus dolor voluptatum optio cupiditate.',
          style: TextStyle(color: AppColors.grey, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildNotificationsToggle() {
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Obx(
                () => Text(
                  'Enable notifications'.tr,
                  style: TextStyle(fontSize: 16.0, color: AppTheme.textColor()),
                ),
              ),
              Spacer(),
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(4),
                ),
                activeColor: AppColors.green,
                value: false,
                onChanged: (final bool? val) {
                  // if (val!) {
                  //   LocalStorageService.storeSaveUsernameSetting(true);
                  // } else {
                  //   LocalStorageService.storeSaveUsernameSetting(false);
                  // }
                },
                // side: BorderSide(color: AppColors.grey),
              ),
            ],
          ),
          Text(
            'Aut est numquam dolorem qui quae aut. Non temporibus dolor voluptatum optio cupiditate.',
            style: TextStyle(
              color: AppColors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return LaPage(
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16.0),
                _buildHeaderRow(),
                const SizedBox(height: 16.0),
                _buildNotificationsToggle(),
                _buildDarkModeToggle(),
                _buildBiometricsToggle(),
                const Spacer(),
                LaButton(
                  action: UserStateController.logout,
                  label: 'logout'.tr, // TODO(RV): Add i18n strings
                ),
                const Divider(indent: 32.0, endIndent: 32.0),
                LaButton(
                  action: () => Get.dialog(PrivacyPolicyDialog()),
                  label: 'Privacy Policy'.tr, // TODO(RV): Add i18n strings
                ),
                LaButton(
                  action: () => Get.dialog(TosDialog()),
                  label: 'Terms of Service'.tr, // TODO(RV): Add i18n strings
                ),
                const Divider(indent: 32.0, endIndent: 32.0),
                LaButton(
                  action: Get.back,
                  label: 'Close'.tr, // TODO(RV): Add i18n strings
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
