import 'package:movies/util/constant.dart';
import 'package:movies/util/localization_manager.dart';
import 'package:movies/util/router_manager.dart';
import 'package:movies/util/storage_manager.dart';
import 'package:movies/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';



void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  await StorageManager.setup();
  await LocalizationManger.setup();

  RouterManager.setup();

  runApp(MovieApp());
}

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
        providers: providers,
        child: Consumer<ThemeViewModel>(
          builder: (context, _, widget) {

            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightData,
                darkTheme: darkData,
                themeMode: StorageManager.themeMode,
                onGenerateRoute: RouterManager.router.generator,
                localizationsDelegates: [
                  LocalizationManger.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ]
            );
          },
        )
    );
  }
}



