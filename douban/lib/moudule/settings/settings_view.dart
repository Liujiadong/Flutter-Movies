import 'package:douban/util/constant.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/util/storage_manager.dart';
import 'package:douban/view_model/language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:douban/view_model/theme_view_model.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
          title: Consumer<LanguageViewModel>(builder: (context, _, child) {
        return Text(LocalizationManger.i18n(context, 'settings.title'));
      })),
      body: ListView(
        children: <Widget>[
          ListTile(
              title: Consumer<LanguageViewModel>(builder: (context, _, child) {
                return Text(
                    LocalizationManger.i18n(context, 'settings.language'));
              }),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return SimpleDialog(
                          children: Language.values.map<Widget>((v) {
                        return RadioListTile(
                          value: v,
                          groupValue: StorageManager.language,
                          activeColor: ConsColor.theme,
                          title: Text(languageName(v)),
                          onChanged: (_) {
                            RouterManager.pop(context);
                            Provider.of<LanguageViewModel>(context,
                                    listen: false)
                                .refresh(context, v);
                          },
                        );
                      }).toList());
                    });
              }),
          Divider(),
          ListTile(
              title: Consumer<LanguageViewModel>(builder: (context, _, child) {
                return Text(LocalizationManger.i18n(context, 'settings.theme'));
              }),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return SimpleDialog(
                          children: ThemeType.values.map<Widget>((v) {
                        return RadioListTile(
                          value: v,
                          groupValue: StorageManager.theme,
                          activeColor: ConsColor.theme,
                          title: Text(
                              LocalizationManger.i18n(context, themeKey(v))),
                          onChanged: (_) {
                            RouterManager.pop(context);
                            Provider.of<ThemeViewModel>(context, listen: false)
                                .change(v);
                          },
                        );
                      }).toList());
                    });
              }),
          Divider(),
          ListTile(
              title: Consumer<LanguageViewModel>(builder: (context, _, child) {
                return Text(
                    LocalizationManger.i18n(context, 'settings.version'));
              }),
              trailing: Text(
                  'v ${StorageManager.packageInfo.version}(${StorageManager.packageInfo.buildNumber})')
          ),
        ],
      ),
    );
  }
}
