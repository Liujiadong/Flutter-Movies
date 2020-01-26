
import 'package:douban/util/localization_manager.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageKey {
  static const theme = 'kTheme';
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


  static set theme(ThemeType theme) {
    prefs.setString(StorageKey.theme, themeName(theme));
  }

  static get theme => themeType(prefs.getString(StorageKey.theme) ?? themeName(ThemeType.light));


}