import 'package:douban/moudule/detail/comments_view.dart';
import 'package:douban/moudule/detail/detail_view.dart';
import 'package:douban/moudule/detail/reviews_view.dart';
import 'package:douban/moudule/home/home_view.dart';
import 'package:douban/moudule/settings/settings_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

enum RouterType {
  home,
  detail,
  comments,
  reviews,
  settings
}


String path(RouterType type) {
  switch (type) {
    case RouterType.home:
      return '/home';
    case RouterType.detail:
      return '/detail';
    case RouterType.settings:
      return '/settings';
    case RouterType.comments:
      return '/comments';
    case RouterType.reviews:
      return '/reviews';
    default:
      return '/';
  }
}

Handler handler(RouterType type) {
  return Handler(handlerFunc: (context, params) {

    switch (type) {
      case RouterType.home:
        return HomeView();
      case RouterType.detail:
        return DetailView(params['id']?.first);
      case RouterType.comments:
        return CommentsView(params['id']?.first, params['title'].first);
      case RouterType.reviews:
        return ReviewsView(params['id']?.first, params['title'].first);
      case RouterType.settings:
        return SettingsView();
      default:
        return HomeView();
    }
  });
}

TransitionType transitionType(RouterType type) {
  switch (type) {

    case RouterType.comments:
      return TransitionType.materialFullScreenDialog;
    default:
      return TransitionType.material;
  }
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


  static navigateTo(BuildContext context, RouterType type, {String params = ''}) {

    final _path = path(type);
    final _transition = transitionType(type);
    switch (type) {
      default:
        router.navigateTo(
            context,
            _path + (params.isEmpty ? params : '?$params'),
            transition: _transition);
    }

  }

}