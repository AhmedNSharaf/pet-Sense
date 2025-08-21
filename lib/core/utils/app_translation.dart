import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  static Map<String, Map<String, String>> _localizedValues = {};

  // تحميل ملفات JSON
  static Future<void> init() async {
    final enJson = await rootBundle.loadString('assets/langs/en.json');
    final arJson = await rootBundle.loadString('assets/langs/ar.json');

    _localizedValues = {
      'en_US': Map<String, String>.from(json.decode(enJson)),
      'ar_EG': Map<String, String>.from(json.decode(arJson)),
    };
  }

  @override
  Map<String, Map<String, String>> get keys => _localizedValues;
}
