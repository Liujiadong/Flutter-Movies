import 'package:douban/view_model/language_view_model.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => ThemeViewModel()),
  ChangeNotifierProvider(create: (_) => LanguageViewModel())
];

