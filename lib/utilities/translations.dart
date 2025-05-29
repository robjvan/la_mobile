import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/utilities/i18n/en.dart';
import 'package:la_mobile/utilities/i18n/es.dart';
import 'package:la_mobile/utilities/i18n/fr.dart';

@immutable
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
    'en': englishStrings,
    'fr': frenchStrings,
    'es': spanishStrings,
  };
}
