import 'package:movies/moudule/movie/comments_view.dart';
import 'package:movies/moudule/movie/detail_view.dart';
import 'package:movies/moudule/movie/photos_view.dart';
import 'package:movies/moudule/movie/reviews_view.dart';
import 'package:movies/moudule/rank/rank_list_view.dart';

import 'package:movies/moudule/settings/settings_detail_view.dart';
import 'package:movies/moudule/settings/settings_view.dart';
import 'package:movies/moudule/tab/tabBar_view.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter/cupertino.dart';

enum RouterType {
  root,
  detail,
  rank_list,
  comments,
  reviews,
  photos,
  settings,
  settings_detail,
}


String path(RouterType type) {
  switch (type) {
    case RouterType.detail:
      return '/detail';
    case RouterType.settings:
      return '/settings';
    case RouterType.comments:
      return '/interests';
    case RouterType.reviews:
      return '/reviews';
    case RouterType.settings_detail:
      return '/settings/detail';
    case RouterType.rank_list:
      return '/rank/list';
    case RouterType.photos:
      return '/photos';
    default:
      return '/';
  }
}

Handler handler(RouterType type) {
  return Handler(handlerFunc: (context, params) {

    switch (type) {
      case RouterType.detail:
        return DetailView(params['id'].first, params['title'].first);
      case RouterType.comments:
        return CommentsView(params['id'].first, params['title'].first);
      case RouterType.reviews:
        return ReviewsView(params['id'].first, params['title'].first);
      case RouterType.settings:
        return SettingsView();
      case RouterType.settings_detail:
        return SettingsDetailView(params['type'].first);
      case RouterType.rank_list:
        return RankListView(params['id'].first, params['title'].first);
      case RouterType.photos:
        return PhotosView(params['id'].first, params['title'].first);
      default:
        return TabBarView();
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

  static FluroRouter router = FluroRouter();

  static setup() {

   // router.notFoundHandler

    RouterType.values.forEach((v){
      router.define(path(v), handler: handler(v));
    });
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }


  static _navigateTo(BuildContext context, RouterType type, {String params = ''}) {

    final _path = path(type);
    final _transition = transitionType(type);
    switch (type) {
      default:
        router.navigateTo(
            context,
            _path + (params.isEmpty ? params : '?$params'),
            transition: _transition,
            transitionDuration: const Duration(milliseconds: 600));
    }

  }

  static toMovie(BuildContext context, RouterType type, String id, String title) {
    String params = 'id=$id&title=${Uri.encodeComponent(title)}';
    _navigateTo(context, type, params: params);
  }

  static toSetting(BuildContext context, String type) {
    _navigateTo(context, RouterType.settings_detail, params: 'type=$type');
  }

}