import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  Future<AppLocalizations> load(context) async {
    String data = await DefaultAssetBundle.of(context).loadString('assets/i18n/${locale.languageCode}.json');
    _localizedValues = json.decode(data);
    return this;
  }

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, dynamic> _localizedValues;

  String translate(String key, [int howMany = 1]) {
    if (!_localizedValues.containsKey(key)) { return key; }

    return Intl.plural(howMany,
      zero: _localizedValues[key][1],
      one: _localizedValues[key][0],
      many: _localizedValues[key][1],
      other: _localizedValues[key][1],
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate(this.context);

  final BuildContext context;

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations(locale).load(context);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
