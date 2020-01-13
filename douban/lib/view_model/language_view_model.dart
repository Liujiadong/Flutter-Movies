import 'package:douban/util/localization_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LanguageViewModel extends ChangeNotifier {

   select(BuildContext context, Language language) {
    FlutterI18n.refresh(context, languageLocal(language));
    notifyListeners();
  }

}