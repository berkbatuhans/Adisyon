import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseHelper {
  Future<void> showSnackBar(String message, [MaterialColor color = Colors.red]);
}

class Helper implements BaseHelper {
  static Helper _instance;
  factory Helper() => _instance ??= new Helper._();
  Helper._();
  String _map;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getFromSharedPreference(String pref) async {
    try {
      final SharedPreferences preferences = await _prefs;
      final getPref = preferences.getString(pref);
      if (getPref != null) {
        this._map = getPref;
      } else {
        print('Shared Preference has no data');
      }
    } catch (e) {
      print('Hata getFromSharedPreference method');
      print(e.toString());
    }

    return this._map;
  }

  Future setFromSharedPreference(String key, String value) async {
    final SharedPreferences preferences = await _prefs;
    preferences.setString(key, value);
  }

  showSnackBar(String message, [MaterialColor color = Colors.red]) {
    new SnackBar(
      backgroundColor: color,
      content: new Text(message),
    );
  }
}
