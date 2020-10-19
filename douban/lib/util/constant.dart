import 'package:douban/moudule/home/home_view.dart';
import 'package:douban/moudule/rank/rank_view.dart';
import 'package:douban/moudule/settings/settings_view.dart';
import 'package:flutter/material.dart';

class TabNavigationItem {

  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items {
    return [
      TabNavigationItem(
        page: HomeView(),
        icon: Icon(Icons.local_play),
        title: Text(''),
      ),
      TabNavigationItem(
        page: RankView(),
        icon: Icon(Icons.bookmark_border),
        title: Text(''),
      ),
      TabNavigationItem(
        page: SettingsView(),
        icon: Icon(Icons.settings),
        title: Text(''),
      ),
    ];
  }
}

class HexToColor extends Color{
  static _hexToColor(String code) {
    return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
  }
  HexToColor(final String code) : super(_hexToColor(code));
}

class ConsColor {
  static final theme = HexToColor('#52BE80');
  static final border = HexToColor('#657271');
}

class Api {

  static const fetchMovieList = '/subject_collection';
  static const fetchMovie = '/movie';
  static const fetchRanks = '/movie/rank_list';

  static String itemsPath(String extra) {
    return '/$extra/items';
  }


}




Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}
double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}