import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/plants.controller.dart';
import 'package:la_mobile/controllers/user.controller.dart';
import 'package:la_mobile/secrets.dart';

// This class is responsible for making API calls and handling responses.
class NetworkService {
  static Future<http.Response> checkNetworkConnection() async {
    try {
      final http.Response result = await http.get(
        Uri.parse(AppSecrets.serverUrl),
      );

      if (result.statusCode == 200 && result.body == 'pong') {
        return result;
      } else {
        return http.Response('Could not connect to server', 404);
      }
    } on Exception catch (err) {
      debugPrint(err.toString());
      return http.Response('Could not connect to server', 404);
    }
  }

  static Future<dynamic> login(
    final String username,
    final String password,
  ) async {
    try {
      final http.Response response = await http.post(
        Uri.parse('${AppSecrets.serverUrl}/$kLoginEndpoint'),
        body: <String, String>{'username': username, 'password': password},
      );

      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 500 &&
          jsonDecode(response.body)['error'].contains('credentials')) {
        print('bad creds bro');
        // TODO(RV): Show user a dialog stating that credentials were incorrect
      }
      return response;
    } on Exception catch (err) {
      print(err);
    }
  }

  static void logout() {
    UserController.clearUser();
    PlantsController.clearPlants();

    Get.offAllNamed(kLoginRouteName);
  }
}
