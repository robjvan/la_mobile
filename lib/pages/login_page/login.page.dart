import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/pages/login_page/login_page_widgets.dart';
import 'package:la_mobile/services/local_storage.service.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/la_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // bool _passwordObscured = true;
  // bool _rememberUsername = false;

  // ignore: always_specify_types
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    LocalStorageService.loadSaveUsernameSetting();

    //! Used for testing, remove for prod
    // usernameController.text = 'dad@dad.com';
    _passwordController.text = 'Asdf123!';
    if (AppStateController.saveUsername.value) {
      _usernameController.text = UserStateController.username.value;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildLoadingWidget() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 32.0,
          child: CircularProgressIndicator(color: AppColors.green),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Logging in...'.tr, // TODO(RV): Add i18n strings
          style: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
            // fontWeight: FontWeight.bold,
            color: AppTheme.textColor(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(final BuildContext context) {
    return LaPage(
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                Hero(
                  tag: 'app-logo',
                  child: Image.asset(kAppLogoPath, height: 250.0),
                ),
                Text(
                  'app_title'.tr,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color:
                        AppStateController.isLoading.value
                            ? AppColors.lightGrey
                            : AppColors.green,
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
                        UsernameField(usernameController: _usernameController),
                        const RememberUsernameButton(),
                        const SizedBox(height: 8.0),
                        PasswordField(passwordController: _passwordController),
                        const ForgotPasswordButton(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                AppStateController.isLoading.value
                    ? _buildLoadingWidget()
                    : LoginButton(
                      formKey: _formKey,
                      usernameController: _usernameController,
                      passwordController: _passwordController,
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
