import 'package:get/get_rx/get_rx.dart';

class SettingsController {
  static RxBool useDarkMode = false.obs;

  static void toggleDarkMode() {
    if (SettingsController.useDarkMode.value) {
      SettingsController.useDarkMode.value = false;
    } else {
      SettingsController.useDarkMode.value = true;
    }
  }
}
