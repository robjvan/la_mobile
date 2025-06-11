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
