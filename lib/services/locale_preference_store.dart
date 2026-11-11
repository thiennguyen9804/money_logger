import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalePreferenceStore {
  LocalePreferenceStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const _localeKey = 'app_locale';

  final SharedPreferencesAsync _preferences;

  Future<Locale?> read() async {
    final localeId = await _preferences.getString(_localeKey);
    return localeFromId(localeId);
  }

  Future<void> write(Locale locale) async {
    final localeId = localeIdFor(locale);
    if (localeId == null) {
      throw ArgumentError.value(
        locale,
        'locale',
        'Unsupported application locale',
      );
    }
    await _preferences.setString(_localeKey, localeId);
  }

  static Locale? localeFromId(String? localeId) => switch (localeId) {
    'en_US' => const Locale('en', 'US'),
    'vi_VN' => const Locale('vi', 'VN'),
    _ => null,
  };

  static String? localeIdFor(Locale locale) {
    if (locale.languageCode == 'en') return 'en_US';
    if (locale.languageCode == 'vi') return 'vi_VN';
    return null;
  }

  static Locale localeFromDevice(Locale locale) {
    if (locale.languageCode == 'vi') return const Locale('vi', 'VN');
    if (locale.languageCode == 'en') return const Locale('en', 'US');
    return const Locale('en', 'US');
  }
}
