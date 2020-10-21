import 'package:movies/util/localization_manager.dart';
import 'package:movies/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorView extends StatelessWidget {

  String message;
  VoidCallback onRefresh;

  ErrorView(this.message, {this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeViewModel>(context);
    final themeData = theme.data(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(LocalizationManger.i18n(context, message),
              style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
          SizedBox(height: 15),
          RaisedButton(
            color: themeData.primaryColor,
            child: Text(LocalizationManger.i18n(context, 'refresh.reload'),
                style: TextStyle(color: Colors.white)),
            onPressed: onRefresh,
          )
        ],
      ),
    );
  }
}