import 'package:get/get_rx/get_rx.dart';

class SettingsController {
  static RxBool isLoading = false.obs;

  static RxBool useDarkMode = false.obs;

  static RxBool showFilterBar = false.obs;

  static RxBool viewAsList = false.obs;

  static void toggleDarkMode() {
    if (SettingsController.useDarkMode.value) {
      SettingsController.useDarkMode.value = false;
    } else {
      SettingsController.useDarkMode.value = true;
    }
  }

  static void toggleFilterBar() {
    if (SettingsController.showFilterBar.value) {
      SettingsController.showFilterBar.value = false;
    } else {
      SettingsController.showFilterBar.value = true;
    }
    print(SettingsController.showFilterBar.value);
  }

  static void toggleListView() {
    if (SettingsController.viewAsList.value) {
      SettingsController.viewAsList.value = false;
    } else {
      SettingsController.viewAsList.value = true;
    }
    print(SettingsController.viewAsList.value);
  }
}
