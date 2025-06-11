import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/secrets.dart';

class UsersService {
  // Singleton instance
  static final UsersService _instance = UsersService._internal();

  // Public factory constructor to return the same instance
  factory UsersService() => _instance;

  // Private constructor
  UsersService._internal();

  /// Attempt to log in with provided username and password
  Future<dynamic> login(final String username, final String password) async {
    try {
      final http.Response response = await http.post(
        Uri.parse('${AppSecrets.serverUrl}/$kAuthEndpoint/login'),
        body: <String, String>{'username': username, 'password': password},
      );

      return response;
    } on Exception catch (err) {
      print(err);
    }
  }

  /// Submit a forgot password request for the given username
  Future<dynamic> submitForgotPasswordRequest(final String username) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(
          '${AppSecrets.serverUrl}/$kAuthEndpoint/forgot-password/$username}',
        ),
      );

      return response;
    } on Exception catch (err) {
      print(err);
    }
  }
}
