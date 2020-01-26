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
      })
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
              title: Consumer<LanguageViewModel>(builder: (context, _, child) {
                return Text(
                    LocalizationManger.i18n(context, 'settings.language'));
              }),
              leading: Icon(Icons.language),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return SimpleDialog(
                          title: Consumer<LanguageViewModel>(
                              builder: (context, _, child) {
                            return Text(LocalizationManger.i18n(
                                context, 'settings.select'));
                          }),
                          children:
                              Language.values.map<SimpleDialogOption>((v) {
                            return SimpleDialogOption(
                              child: Text(languageName(v)),
                              onPressed: () {
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
          SwitchListTile(
              secondary: theme.icon,
              title: Consumer<LanguageViewModel>(builder: (context, _, child) {
                return Text(
                    LocalizationManger.i18n(context, 'settings.dark_mode'));
              }),
              value: theme.isDark,
              onChanged: (_) {
                Provider.of<ThemeViewModel>(context, listen: false).change();
              }),
          Divider(),
          SizedBox(
            height: 100,
            child: Center(
                child: Text('v ${StorageManager.packageInfo.version}(${StorageManager.packageInfo.buildNumber})')
            ),
          )
        ],
      ),
    );
  }
}
