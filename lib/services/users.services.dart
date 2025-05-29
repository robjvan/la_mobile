import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/secrets.dart';

class UsersService {
  static Future<dynamic> login(
    final String username,
    final String password,
  ) async {
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

  static Future<dynamic> submitForgotPasswordRequest(
    final String username,
  ) async {
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
