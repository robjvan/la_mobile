import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:la_mobile/secrets.dart';

class NetworkService {
  static Future<http.Response> checkNetworkConnection() async {
    try {
      final http.Response result = await http.get(
        Uri.parse(AppSecrets.serverUrl),
      );

      if (result.statusCode == 200 && result.body == 'pong') {
        return result;
      } else {
        return http.Response(
          'Could not connect to server'.tr, // TODO(RV): Add i18n strings
          404,
        );
      }
    } on Exception catch (err) {
      debugPrint(err.toString());
      return http.Response(
        'Could not connect to server', // TODO(RV): Add i18n strings
        404,
      );
    }
  }
}
