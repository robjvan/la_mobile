import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/user.model.dart';
import 'package:la_mobile/services/local_storage.service.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/services/users.services.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';
import 'package:la_mobile/widgets/dialogs/bad_credentials.dialog.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const LoginButton({
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return LaButton(
      action: () async {
        if (formKey.currentState!.validate()) {
          final dynamic response = await UsersService.login(
            usernameController.text,
            passwordController.text,
          );

          if (response.statusCode == 201) {
            // If user wants to store their username, store it with GetStorage
            if (AppStateController.saveUsername.value) {
              LocalStorageService.storeUsername(usernameController.text);
            }

            // Set the local user data using API response
            UserStateController.setUserData(
              UserModel.fromMap(jsonDecode(response.body)),
            );

            // Fetch user data - user, profile, plants, etc.
            await PlantsService.fetchUserPlants();

            // Navigate to dashboard
            unawaited(Get.offAllNamed(kHomeRouteName));
          } else {
            unawaited(Get.dialog(const BadCredentialsDialog()));
          }
        }
      },
      label: 'login'.tr,
    );
  }
}
