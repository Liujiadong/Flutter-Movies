import 'package:douban/util/constant.dart';
import 'package:douban/util/storage_manager.dart';
import 'package:flutter/material.dart';

enum ThemeType {
  light,
  dark,
 // system
}

String themeName(ThemeType type) {
  switch (type) {
    case ThemeType.dark:
      return 'dark';
    case ThemeType.light:
      return 'light';
    default:
      return 'system';
  }
}

String themeKey(ThemeType type) {
  switch (type) {
    case ThemeType.dark:
      return 'settings.theme_dark';
    case ThemeType.light:
      return 'settings.theme_light';
    default:
      return 'settings.theme_system';
  }
}

ThemeType themeType(String name) {
  switch (name) {
    case 'dark':
      return ThemeType.dark;
    case 'light':
      return ThemeType.light;
  }
}

class ThemeViewModel extends ChangeNotifier {

  ThemeType _type = StorageManager.theme;


  ThemeData get data {
    switch (_type) {
      case ThemeType.light:
        return ThemeData.light().copyWith(
          primaryColor: ConsColor.theme
        );
      default:
        return ThemeData.dark();
    }
  }


  bool get isDark {
    return _type == ThemeType.dark;
  }


  change(ThemeType type) {

    _type = type;
    StorageManager.theme = _type;
    notifyListeners();
  }

}