import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/pages/about_page/about.page.dart';
import 'package:la_mobile/pages/contact_page/contact_us.page.dart';
import 'package:la_mobile/pages/forgot_pass_page/forgot_password.page.dart';
import 'package:la_mobile/pages/home_page/home.page.dart';
import 'package:la_mobile/pages/login_page/login.page.dart';
import 'package:la_mobile/pages/privacy_page/privacy.page.dart';
// import 'package:la_mobile/pages/profile_page/profile.page.dart';
import 'package:la_mobile/pages/register_page/register.page.dart';
import 'package:la_mobile/pages/splash_page/splash.page.dart';
import 'package:la_mobile/pages/tos_page/tos.page.dart';

class AppRoutes {
  static const String initialRoute = kSplashPage;

  /// Define the routes for the app
  static final List<GetPage<dynamic>> getPages = <GetPage<dynamic>>[
    GetPage<dynamic>(name: kHomeRouteName, page: HomePage.new),
    GetPage<dynamic>(name: kLoginRouteName, page: LoginPage.new),
    GetPage<dynamic>(name: kRegisterRouteName, page: RegisterPage.new),
    GetPage<dynamic>(
      name: kForgotPasswordRouteName,
      page: ForgotPasswordPage.new,
    ),
    // GetPage<dynamic>(name: kProfileRouteName, page: ProfilePage.new),
    GetPage<dynamic>(name: kAboutRouteName, page: AboutPage.new),
    GetPage<dynamic>(name: kContactUsRouteName, page: ContactUsPage.new),
    GetPage<dynamic>(
      name: kPrivacyPolicyRouteName,
      page: PrivacyPolicyPage.new,
    ),
    GetPage<dynamic>(name: kTermsOfServiceRouteName, page: TosPage.new),
    GetPage<dynamic>(name: kSplashPage, page: SplashPage.new),
  ];
}
