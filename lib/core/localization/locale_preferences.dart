import 'dart:io';

import 'package:hiddify/core/preferences/preferences_provider.dart';
import 'package:hiddify/gen/translations.g.dart';
import 'package:hiddify/utils/custom_loggers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_preferences.g.dart';

@Riverpod(keepAlive: true)
class LocalePreferences extends _$LocalePreferences with AppLogger {
  @override
  AppLocale build() {
    final persisted = ref.watch(sharedPreferencesProvider).requireValue.getString("locale");
    if (persisted == null) {
      try {
        final deviceLocale = AppLocaleUtils.findDeviceLocale();
        final systemLocale = Platform.localeName.toLowerCase();
        if (systemLocale.contains("zh") || systemLocale.contains("hans") || systemLocale.contains("cn") || deviceLocale == AppLocale.en) {
          return AppLocale.zhCn;
        }
        return deviceLocale;
      } catch (_) {
        return AppLocale.zhCn;
      }
    }
    // keep backward compatibility with chinese after changing zh to zh_CN
    if (persisted == "zh" || persisted == "zh_CN" || persisted == "zh-CN" || persisted == "zh_Hans") {
      return AppLocale.zhCn;
    }
    try {
      return AppLocale.values.byName(persisted);
    } catch (e) {
      loggy.error("error setting locale: [$persisted]", e);
      return AppLocale.zhCn;
    }
  }

  Future<void> changeLocale(AppLocale value) async {
    state = value;
    await ref.read(sharedPreferencesProvider).requireValue.setString("locale", value.name);
  }
}
