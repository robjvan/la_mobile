import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/pages/login_page/widgets/username.field.dart';
import 'package:la_mobile/services/users.services.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';
import 'package:la_mobile/widgets/buttons/la_cancel_button.dart';
import 'package:la_mobile/widgets/dialogs/check_email_dialog.dart';
import 'package:la_mobile/widgets/dialogs/new_password_dialog.dart';
import 'package:la_mobile/widgets/la_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _usernameController = TextEditingController();

  // ignore: always_specify_types
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Widget _buildSubmitButton() {
    return LaButton(
      action: () async {
        if (_formKey.currentState!.validate()) {
          // Send a request to the backend to start forgot password workflow
          final dynamic response =
              await UsersService.submitForgotPasswordRequest(
                _usernameController.text,
              );

          if (response.statusCode == 200) {
            // Show dialog telling user to check email
            await Get.dialog(CheckEmailDialog());

            // When they click "Ok" in the dialog, show "enter token/new password" dialog
            final bool result = await Get.dialog(NewPasswordDialog());

            if (result) {
              // If OK response is returned, show dialog confirming password has been changed
              // When user clicks "Ok", route to login page
            }
            // TODO(RV): Add logic
          }
        }
      },
      label: 'submit'.tr,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return LaPage(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Hero(
              tag: 'app-logo',
              child: Image.asset(kAppLogoPath, height: 200.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'forgot-password'.tr,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48.0),
            Text(
              'Reiciendis deleniti quia deserunt asperiores amet rerum omnis accusamus sunt. Error dolore voluptatum incidunt. Eius voluptatem voluptatem quidem vero unde quos est. Sapiente quo minima.',
            ),
            const SizedBox(height: 32.0),
            Form(
              key: _formKey,
              child: UsernameField(usernameController: _usernameController),
            ),
            const SizedBox(height: 32.0),
            _buildSubmitButton(),
            const SizedBox(height: 16.0),
            const LaCancelButton(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
