import 'package:douban/util/constant.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view_model/language_view_model.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:douban/util/storage_manager.dart';

class SettingsDetailView extends StatelessWidget {
  String type;
  SettingsDetailView(this.type);
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(title: Text(LocalizationManger.i18n(context, type))),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: _listItems).toList(),
      ),
    );
  }

  get _listItems {
    switch (type) {
      case 'settings.language':
        return _languageItems;
      default:
        return _themeItems;
    }
  }

  get _languageItems {
    return Language.values.map((v) {

      bool isCurrent = v == StorageManager.language;

      return ListTile(
        title: Text(languageName(v)),
        trailing: isCurrent
            ? Icon(Icons.check, color: ConsColor.theme)
            : null,
        onTap: () {
          if (!isCurrent) {
            Provider.of<LanguageViewModel>(_context, listen: false)
                .refresh(_context, v);
          }
          RouterManager.pop(_context);
        },
      );
    }).toList();
  }

  get _themeItems {
    return ThemeMode.values.map<Widget>((v) {

      bool isCurrent = v == StorageManager.themeMode;

      return ListTile(
        title: Text(LocalizationManger.i18n(_context, themeKey(v))),
        trailing: isCurrent
            ? Icon(Icons.check, color: ConsColor.theme)
            : null,
        onTap: () {
          if (!isCurrent) {
            Provider.of<ThemeViewModel>(_context, listen: false).change(v);
          }
          RouterManager.pop(_context);
        },
      );
    }).toList();
  }
}
