import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
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

      return response;
    } on Exception catch (err) {
      print(err);
    }
  }

  static Future<dynamic> fetchUserPlants() async {
    try {
      final http.Response response = await http.get(
        Uri.parse(
          '${AppSecrets.serverUrl}/$kPlantsEndpoint/byuser/${UserController.user.value.userId}',
        ),
        headers: <String, String>{
          'Authorization': 'Bearer ${UserController.user.value.accessToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      return response;
    } on Exception catch (err) {
      print(err);
    }
  }
}
