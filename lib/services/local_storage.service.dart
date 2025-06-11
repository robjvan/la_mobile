import 'package:get_storage/get_storage.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/user.model.dart';

class LocalStorageService {
  // Singleton instance
  static final LocalStorageService _instance = LocalStorageService._internal();

  // GetStorage instance (only created once)
  final GetStorage _box = GetStorage();

  // Public factory constructor to return the same instance
  factory LocalStorageService() => _instance;

  // Private constructor
  LocalStorageService._internal();

  /// Load saved username, if available
  void loadUsername() {
    try {
      final String? username = _box.read('username');
      if (username != null && username.isNotEmpty) {
        UserStateController.username.value = username;
      }
    } on Exception catch (e) {
      print('Error loading username: $e');
    }
  }

  /// Load saved password (stub)
  void loadPassword() {
    // TODO: Implement
  }

  /// Load local user data (stub)
  void loadUserData() {
    // TODO: Implement
  }

  /// Load user settings (stub)
  void loadUserSettings() {
    // TODO: Implement
  }

  /// Store a new username
  void storeUsername(final String username) {
    try {
      _box.write('username', username);
    } on Exception catch (e) {
      print('Error storing username: $e');
    }
  }

  /// Store user data (stub)
  void storeUserData(final UserModel user) {
    // TODO: Implement
  }

  /// Store a user setting (stub)
  void storeUserSettings(final String key, final String value) {
    // TODO: Implement
  }

  /// Load and apply the 'saveUsername' preference
  void loadSaveUsernameSetting() {
    try {
      final bool? saveUsername = _box.read('saveUsername');
      if (saveUsername == true) {
        AppStateController.saveUsername.value = true;
        loadUsername();
      }
    } on Exception catch (e) {
      print('Error loading saveUsername setting: $e');
    }
  }

  /// Store the 'saveUsername' preference
  void storeSaveUsernameSetting(final bool value) {
    try {
      _box.write('saveUsername', value);
    } on Exception catch (e) {
      print('Error storing saveUsername setting: $e');
    }
  }

  /// Clear saved credentials (stub)
  void clearCredentials() {
    // TODO: Implement
  }
}

// import 'package:get_storage/get_storage.dart';
// import 'package:la_mobile/controllers/app_state.controller.dart';
// import 'package:la_mobile/controllers/user_state.controller.dart';
// import 'package:la_mobile/models/user.model.dart';

// class LocalStorageService {
//   // Local storage methods

//   // Load username if available
//   static void loadUsername() {
//     try {
//       final String? username = GetStorage().read('username');

//       if (username == null || username == '') {
//         return;
//       }
//       UserStateController.username.value = username;
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   // Load username if available
//   static void loadPassword() {
//     //
//   }

//   // Load local user data if available
//   static void loadUserData() {
//     //
//   }

//   // Load user settings if available
//   static void loadUserSettings() {
//     //
//   }

//   // Load username if available
//   static void storeUsername(final String username) {
//     try {
//       GetStorage().write('username', username);
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   // // Load username if available
//   // static void savePassword() {
//   //   //
//   // }

//   // Save user data
//   static void storeUserData(final UserModel user) {
//     //
//   }

//   // Save user settings
//   static void storeUserSettings(final String key, final String value) {
//     //
//   }

//   static void loadSaveUsernameSetting() {
//     try {
//       final bool? saveUsername = GetStorage().read('saveUsername');

//       if (saveUsername != null && saveUsername) {
//         AppStateController.saveUsername.value = true;
//         LocalStorageService.loadUsername();
//       }
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   static void storeSaveUsernameSetting(final bool value) {
//     try {
//       GetStorage().write('saveUsername', value);
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   static void clearCredentials() {
//     //
//   }
// }
