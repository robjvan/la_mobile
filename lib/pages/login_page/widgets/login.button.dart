import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/plants.controller.dart';
import 'package:la_mobile/controllers/user.controller.dart';
import 'package:la_mobile/models/user.model.dart';
import 'package:la_mobile/services/network.service.dart';
import 'package:la_mobile/widgets/dialogs/bad_credentials.dialog.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';

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
          final dynamic response = await NetworkService.login(
            usernameController.text,
            passwordController.text,
          );

          if (response.statusCode == 201) {
            UserController.setUserData(
              UserModel.fromMap(jsonDecode(response.body)),
            );

            // Fetch user data - user, profile, plants, etc.
            await PlantsController.fetchUserPlants();

            unawaited(Get.offAllNamed(kHomeRouteName));
          } else {
            unawaited(Get.dialog(const BadCredentialsDialog()));
          }
        }
      },
      label: 'Login',
    );
  }
}
