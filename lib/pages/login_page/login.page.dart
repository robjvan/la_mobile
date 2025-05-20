import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/settings.controller.dart';
import 'package:la_mobile/pages/login_page/login_page_widgets.dart';
import 'package:la_mobile/utilities/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordObscured = true;
  bool rememberUsername = false;

  // ignore: always_specify_types
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Used for testing, remove for prod
    usernameController.text = 'dad@dad.com';
    passwordController.text = 'Asdf123!';
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            SettingsController.useDarkMode.value
                ? AppColors.bgColorDarkMode
                : AppColors.bgColorLightMode,
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                Image.asset('assets/logo/logo.png', height: 250.0),
                Text(
                  'app_title'.tr,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32.0),
                Form(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        UsernameField(usernameController: usernameController),
                        const RememberUsernameButton(),
                        const SizedBox(height: 8.0),
                        PasswordField(passwordController: passwordController),
                        const ForgotPasswordButton(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                LoginButton(
                  formKey: _formKey,
                  usernameController: usernameController,
                  passwordController: passwordController,
                ),
                const Spacer(),
                const NewUserButton(),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
