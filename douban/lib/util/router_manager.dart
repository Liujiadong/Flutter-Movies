import 'package:douban/moudule/detail/detail_view.dart';
import 'package:douban/moudule/home/home_view.dart';
import 'package:douban/moudule/settings/settings_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

enum RouterType {
  home,
  detail,
  settings
}

String path(RouterType type) {
  switch (type) {
    case RouterType.home:
      return 'home';
    case RouterType.detail:
      return 'detail';
    case RouterType.settings:
      return 'settings';
    default:
      return 'none';
  }
}

Handler handler(RouterType type) {
  return Handler(handlerFunc: (context, params) {
    switch (type) {
      case RouterType.home:
        return HomeView();
      case RouterType.detail:
        return DetailView();
      case RouterType.settings:
        return SettingsView();
      default:
        return HomeView();
    }
  });
}


class RouterManager {
  static Router router = Router();
  static setup() {
    RouterType.values.forEach((v){
      router.define(path(v), handler: handler(v));
    });
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }


  static navigateTo(BuildContext context, RouterType type) {
    final _path = path(type);
    switch (type) {
      default:
        router.navigateTo(
            context,
            _path,
            transition: TransitionType.material);
    }

  }

}