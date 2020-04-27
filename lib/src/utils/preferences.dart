import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../resources/movies_api.dart';

class _Preferences {
  SharedPreferences _prefs;

  _Preferences();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get serverUrl => _prefs?.getString('serverUrl') ?? 'http://localhost:3000';
  set serverUrl(String val) {
    val = val.replaceFirst(RegExp(r'/\/$/'), '');

    client.options.baseUrl = '$val/api';
    _prefs?.setString('serverUrl', val);
  }
}

final preferences = _Preferences();
