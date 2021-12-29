import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/common/constants/languages.dart';

class AppLocalization {
  final Locale locale;
  late Map<String, String> _localizedString;

  AppLocalization(this.locale);

  static AppLocalization? of(context) =>
      Localizations.of<AppLocalization>(context, AppLocalization);

  static LocalizationsDelegate<AppLocalization> delegate =
      const _AppLocalizationDelegate();

  Future<bool> load() async {
    final jsonString = await rootBundle
        .loadString("assets/languages/${locale.languageCode}.json");
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedString =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String? translate(String key) {
    return _localizedString[key];
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return Languages.languages
        .map((e) => e.code)
        .toList()
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}
