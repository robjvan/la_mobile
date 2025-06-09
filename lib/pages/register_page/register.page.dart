import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/pages/login_page/widgets/password.field.dart';
import 'package:la_mobile/pages/login_page/widgets/username.field.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';
import 'package:la_mobile/widgets/buttons/la_cancel_button.dart';
import 'package:la_mobile/widgets/la_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _newsletter = true;

  // ignore: always_specify_types
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16.0),
          UsernameField(usernameController: _usernameController),
          const SizedBox(height: 8.0),
          PasswordField(passwordController: _passwordController),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Receive newsletter?',
                style: TextStyle(color: AppTheme.textColor()),
              ),
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(4),
                ),
                activeColor: AppColors.green,
                onChanged: (final bool? val) {
                  setState(() => _newsletter = !_newsletter);
                },
                value: _newsletter,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return LaButton(
      action: () {
        // Send a request to the backend for new user signup
        // If OK response is returned, show dialog telling user to check email
        // "Click the link contained to confirm email address"
        // When they click "Ok" in the dialog, route to login page
        // User can login after they've confirmed email address
        // TODO(RV): Add logic
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
              'sign-up'.tr,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48.0),
            Text(
              'Reiciendis deleniti quia deserunt asperiores amet rerum omnis accusamus sunt. Error dolore voluptatum incidunt. Eius voluptatem voluptatem quidem vero unde quos est. Sapiente quo minima.',
            ),
            const SizedBox(height: 16.0),
            _buildForm(),
            const SizedBox(height: 16.0),
            _buildSubmitButton(),
            const SizedBox(height: 8.0),
            const LaCancelButton(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
