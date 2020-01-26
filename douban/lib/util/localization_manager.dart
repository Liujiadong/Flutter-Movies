import 'package:douban/util/storage_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';

enum Language {
  zh,
  en
}


Language languageType(String name) {
  switch (name) {
    case 'zh':
      return Language.zh;
    case 'en':
      return Language.en;
    default:
      return Language.en;
  }
}

String languageName(Language language) {
  switch (language) {
    case Language.zh:
      return '简体中文';
    case Language.en:
      return 'English';
    default:
      return 'English';
  }
}

String languageFile(Language language) {
  switch (language) {
    case Language.zh:
      return 'zh';
    case Language.en:
      return 'en';
    default:
      return 'en';
  }
}

Locale languageLocal(Language language) {
  return Locale(languageFile(language));
}



class LocalizationManger {

  static FlutterI18nDelegate delegate;
  static Language language = StorageManager.language;
  static final fallbackFile = languageFile(language);
  static final forcedLocale = languageLocal(language);

  static setup() async{
    delegate = FlutterI18nDelegate(
        useCountryCode: false,
        fallbackFile: fallbackFile,
        path: 'assets/i18n',
        forcedLocale: forcedLocale);
    await delegate.load(null);
  }

  static String i18n(BuildContext context, String key) {
    return FlutterI18n.translate(context, key);
  }



}