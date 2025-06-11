import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:la_mobile/secrets.dart';

class NetworkService {
  // Singleton instance
  static final NetworkService _instance = NetworkService._internal();

  // Public factory constructor to return the same instance
  factory NetworkService() => _instance;

  // Private constructor
  NetworkService._internal();

  Future<http.Response> checkNetworkConnection() async {
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
}
