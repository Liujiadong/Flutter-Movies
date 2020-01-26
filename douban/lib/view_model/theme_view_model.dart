import 'package:douban/util/constant.dart';
import 'package:douban/util/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


enum ThemeType {
  dark,
  light
}

String themeName(ThemeType type) {
  switch (type) {
    case ThemeType.dark:
      return 'dark';
    case ThemeType.light:
      return 'light';
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
          primaryColor: ConstColor.theme
        );
      default:
        return ThemeData.dark();
    }
  }

  bool get isDark {
    switch (_type) {
      case ThemeType.dark:
        return true;
      default:
        return false;
    }
  }

  Icon get icon {
    switch (_type) {
      case ThemeType.light:
        return Icon(FontAwesomeIcons.solidSun);
      default:
        return Icon(FontAwesomeIcons.solidMoon);
    }
  }

  change() {

    if (_type == ThemeType.light) {
      _type = ThemeType.dark;
    } else {
      _type = ThemeType.light;
    }
    StorageManager.theme = _type;
    notifyListeners();
  }

}