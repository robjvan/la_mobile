import 'package:get_storage/get_storage.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/user.model.dart';

class LocalStorageService {
  // Local storage methods

  // Load username if available
  static void loadUsername() {
    try {
      final String? username = GetStorage().read('username');

      if (username == null || username == '') {
        return;
      }
      UserStateController.username.value = username;
    } on Exception catch (e) {
      print(e);
    }
  }

  // Load username if available
  static void loadPassword() {
    //
  }

  // Load local user data if available
  static void loadUserData() {
    //
  }

  // Load user settings if available
  static void loadUserSettings() {
    //
  }

  // Load username if available
  static void storeUsername(final String username) {
    try {
      GetStorage().write('username', username);
    } on Exception catch (e) {
      print(e);
    }
  }

  // // Load username if available
  // static void savePassword() {
  //   //
  // }

  // Save user data
  static void storeUserData(final UserModel user) {
    //
  }

  // Save user settings
  static void storeUserSettings(final String key, final String value) {
    //
  }

  static void loadSaveUsernameSetting() {
    try {
      final bool? saveUsername = GetStorage().read('saveUsername');

      if (saveUsername != null && saveUsername) {
        AppStateController.saveUsername.value = true;
        LocalStorageService.loadUsername();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static void storeSaveUsernameSetting(final bool value) {
    try {
      GetStorage().write('saveUsername', value);
    } on Exception catch (e) {
      print(e);
    }
  }

  static void clearCredentials() {
    //
  }
}
