import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hiddify/gen/fonts.gen.dart';
import 'package:hiddify/gen/translations.g.dart';

extension AppLocaleX on AppLocale {
  String get preferredFontFamily =>
      this == AppLocale.fa ? FontFamily.shabnam : (kIsWeb || !Platform.isWindows ? "" : FontFamily.emoji);

  String get localeName => switch (flutterLocale.toString()) {
    "ar" => "العربية",
    "en" => "English",
    "es" => "Spanish",
    "fa" => "فارسی",
    "fr" => "Français",
    "id" => "Indonesian",
    "pt_BR" => "Portuguese (Brazil)",
    "ru" => "Русский",
    "tr" => "Türkçe",
    "zh" || "zh_CN" || "zh_Hans" || "zh_Hans_CN" || "zh-Hans" || "zh-CN" => "简体中文",
    "zh_TW" || "zh_Hant" || "zh_Hant_TW" || "zh_HK" || "zh-Hant" || "zh-TW" || "zh-HK" => "繁體中文",
    _ => "Unknown",
  };
}
