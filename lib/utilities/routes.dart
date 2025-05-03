import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/pages/about-page/about.page.dart';
import 'package:la_mobile/pages/add-plant-page/add-plant.page.dart';
import 'package:la_mobile/pages/contact-page/contact-us.page.dart';
import 'package:la_mobile/pages/forgot-pass-page/forgot-password.page.dart';
import 'package:la_mobile/pages/home-page/home.page.dart';
import 'package:la_mobile/pages/login-page/login.page.dart';
import 'package:la_mobile/pages/privacy-page/privacy.page.dart';
import 'package:la_mobile/pages/profile-page/profile.page.dart';
import 'package:la_mobile/pages/register-page/register.page.dart';
import 'package:la_mobile/pages/settings-page/settings.page.dart';
import 'package:la_mobile/pages/splash-page/splash.page.dart';
import 'package:la_mobile/pages/tos-page/tos.page.dart';

class AppRoutes {
  static const String initialRoute = kInitialRouteName;

  /// Define the routes for the app
  static final List<GetPage<dynamic>> getPages = <GetPage<dynamic>>[
    GetPage<dynamic>(name: kHomeRouteName, page: HomePage.new),
    GetPage<dynamic>(name: kLoginRouteName, page: LoginPage.new),
    GetPage<dynamic>(name: kRegisterRouteName, page: RegisterPage.new),
    GetPage<dynamic>(
      name: kForgotPasswordRouteName,
      page: ForgotPasswordPage.new,
    ),
    GetPage<dynamic>(name: kProfileRouteName, page: ProfilePage.new),
    GetPage<dynamic>(name: kSettingsRouteName, page: SettingsPage.new),
    GetPage<dynamic>(name: kAboutRouteName, page: AboutPage.new),
    GetPage<dynamic>(name: kContactUsRouteName, page: ContactUsPage.new),
    GetPage<dynamic>(
      name: kPrivacyPolicyRouteName,
      page: PrivacyPolicyPage.new,
    ),
    GetPage<dynamic>(name: kTermsOfServiceRouteName, page: TosPage.new),
    GetPage<dynamic>(name: kAddPlantPage, page: AddPlantPage.new),
    GetPage<dynamic>(name: kSplashPage, page: SplashPage.new),
  ];
}
