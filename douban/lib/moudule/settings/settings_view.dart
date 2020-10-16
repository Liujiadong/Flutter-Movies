
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

    return Consumer<LanguageViewModel>(builder: (context, viewModel, _) {
      return Scaffold(
        appBar: AppBar(
            title: Text(LocalizationManger.i18n(context, 'settings.title'))
        ),
        body: ListView(
          children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                    title: Text(LocalizationManger.i18n(context, 'settings.language')),
                    subtitle: Text(languageName(StorageManager.language)),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      _push(context, 'settings.language');
                    }),
                ListTile(
                    title: Text(LocalizationManger.i18n(context, 'settings.theme')),
                    subtitle: Text(LocalizationManger.i18n(context, themeKey(StorageManager.themeMode))),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      _push(context, 'settings.theme');
                    }),
                ListTile(
                    title: Text(LocalizationManger.i18n(context, 'settings.version')),
                    trailing: Text(
                        'v ${StorageManager.packageInfo.version}(${StorageManager.packageInfo.buildNumber})')
                )
              ]
          ).toList()
        ),
      );
    });

  }

  _push(BuildContext context, String type) {
    RouterManager.navigateTo(context, RouterType.settings_detail, params: 'type=$type');
  }

}
