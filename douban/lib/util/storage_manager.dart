
import 'package:douban/util/localization_manager.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageKey {
  static const themeMode = 'kThemeMode';
  static const language = 'kLanguage';
}

class StorageManager {

  static SharedPreferences prefs;
  static PackageInfo packageInfo;

  static setup() async {
    prefs = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();
  }

  static set language(Language language) {
    prefs.setString(StorageKey.language, languageFile(language));
  }

  static get language => languageType(prefs.getString(StorageKey.language) ?? languageFile(Language.en));


  static set themeMode(ThemeMode mode) {
    prefs.setString(StorageKey.themeMode, themeName(mode));
  }

  static get themeMode => fetchThemeMode(prefs.getString(StorageKey.themeMode));


}