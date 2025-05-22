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
        Uri.parse('${AppSecrets.serverUrl}/$kLoginEndpoint'),
        body: <String, String>{'username': username, 'password': password},
      );

      return response;
    } on Exception catch (err) {
      print(err);
    }
  }
}
