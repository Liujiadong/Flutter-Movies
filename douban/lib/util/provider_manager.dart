import 'package:douban/view_model/language_view_model.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => ThemeViewModel()),
  ChangeNotifierProvider(create: (_) => LanguageViewModel())
];

class ProviderWidget extends StatefulWidget {
  @override
  _ProviderWidgetState createState() => _ProviderWidgetState();
}

class _ProviderWidgetState extends State<ProviderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

