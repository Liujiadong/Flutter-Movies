
import 'package:movies/util/util.dart';
import 'package:movies/view_model/language_view_model.dart';
import 'package:movies/view_model/theme_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => ThemeViewModel()),
  ChangeNotifierProvider(create: (_) => LanguageViewModel())
];




class ConsColor {
  static final theme = hexColor('#52BE80');
  static final border = hexColor('#657271');
}

class Api {

  static const fetchMovieList = '/subject_collection';
  static const fetchMovie = '/movie';
  static const fetchRanks = '/movie/rank_list';

  static String itemsPath(String extra) {
    return '/$extra/items';
  }

}








