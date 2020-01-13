import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';


void main() {

  LocalizationManger.setup();
  RouterManager.setup();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeViewModel>(
        builder: (context, theme, _) {
          return MaterialApp(
            theme: theme.data,
            initialRoute: path(RouterType.home),
            onGenerateRoute: RouterManager.router.generator,
            localizationsDelegates: [
              LocalizationManger.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
          );
        },
      )
    );

  }
}

