import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/metrics.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/metrics.model.dart';
import 'package:la_mobile/secrets.dart';

class MetricsService {
  static Map<String, String> buildAuthHeaders() {
    return <String, String>{
      'Authorization': 'Bearer ${UserStateController.user.value.accessToken}',
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  static Future<void> fetchAdminMetrics() async {
    try {
      AppStateController.isLoading.value = true;

      final http.Response response = await http.get(
        Uri.parse('${AppSecrets.serverUrl}/$kAdminEndpoint/metrics'),
        headers: buildAuthHeaders(),
      );

      if (response.statusCode == 200) {
        MetricsController.metrics.value = MetricsModel.fromMap(
          jsonDecode(response.body),
        );
      }

      AppStateController.isLoading.value = false;
    } on Exception catch (e) {
      print(e);
    }
  }
}
