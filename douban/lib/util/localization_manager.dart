import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';

enum Language {
  zh,
  en
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
  static final fallbackFile = languageFile(Language.zh);
  static final forcedLocale = languageLocal(Language.zh);

  static setup() {
    delegate = FlutterI18nDelegate(
        useCountryCode: false,
        fallbackFile: fallbackFile,
        path: 'assets/i18n',
        forcedLocale: forcedLocale);
    WidgetsFlutterBinding.ensureInitialized();
    delegate.load(null);
  }

  static String i18n(BuildContext context, String key) {
    return FlutterI18n.translate(context, key);
  }

}