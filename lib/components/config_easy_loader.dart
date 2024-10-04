import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// Configure the Easy Loader Indicator
/// from flutter_easy_loading package
class ConfigEasyLoader {
  static void darkTheme() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.dark
      ..maskType = EasyLoadingMaskType.black
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..indicatorSize = 45
      ..radius = 10
      ..userInteractions = false
      ..dismissOnTap = false
      ..textStyle = const TextStyle(
        color: kColorWhite,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 12,
      );
  }
}
