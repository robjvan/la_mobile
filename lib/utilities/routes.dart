import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/pages/add_plant_page/add_plant.page.dart';
import 'package:la_mobile/pages/admin_dashboard_page/admin_dashboard.page.dart';
import 'package:la_mobile/pages/forgot_pass_page/forgot_password.page.dart';
import 'package:la_mobile/pages/home_page/home.page.dart';
import 'package:la_mobile/pages/login_page/login.page.dart';
import 'package:la_mobile/pages/register_page/register.page.dart';
import 'package:la_mobile/pages/settings_page/settings.page.dart';
import 'package:la_mobile/pages/splash_page/splash.page.dart';

class AppRoutes {
  static const String initialRoute = kSplashRouteName;

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
    GetPage<dynamic>(name: kSplashRouteName, page: SplashPage.new),
    GetPage<dynamic>(name: kAddPlantPageRoutename, page: AddPlantPage.new),
    GetPage<dynamic>(name: kAdminDashboardRouteName, page: AdminDashboard.new),
    GetPage<dynamic>(name: kSettingsRouteName, page: SettingsPage.new),
  ];
}
