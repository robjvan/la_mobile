import 'package:get/get.dart';
import 'package:la_mobile/models/metrics.model.dart';

class MetricsController {
  static Rx<MetricsModel> metrics = MetricsModel.initial().obs;
}
