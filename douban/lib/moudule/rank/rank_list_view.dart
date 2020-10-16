import 'package:douban/model/movie_model.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';
import 'package:douban/view/movie_card_view.dart';
import 'package:douban/view_model/movie_view_model.dart';
import 'package:douban/view_model/viewState_view_model.dart';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListView extends StatelessWidget {
  String id, title;

  RankListView(this.id, this.title);

  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieListViewModel>(
      model: MovieListViewModel(id),
      builder: (context, model, _) {
        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: SmartRefresher(
              controller: _refreshController,
              header: RefreshHeader(),
              footer: RefreshFooter(),
              enablePullUp: model.movies != null,
              onRefresh: () async {
                model.onRefresh();
              },
              onLoading: () async {
                model.onLoading();
              },
              child: _body(context, model),
            ));
      },
    );
  }

  Widget _body(BuildContext context, MovieListViewModel model) {
    final state = model.viewState;
    final movies = model.movies;

    if (state == ViewState.onRefresh) {
      _refreshController.resetNoData();
      if (model.refreshNoData) {
        return LoadingIndicator();
      }
    }

    if (state == ViewState.refreshCompleted) {
      _refreshController.refreshCompleted();
    }

    if (state == ViewState.refreshError) {
      return ErrorView(model.message, () {
        model.onRefresh();
      });
    }

    if (state == ViewState.empty) {
      return ErrorView(LocalizationManger.i18n(context, 'refresh.empty'), () {
        model.onRefresh();
      });
    }

    if (state == ViewState.onLoading) {
      _refreshController.refreshToIdle();
    }

    if (state == ViewState.loadNoData) {
      _refreshController.loadNoData();
    }

    if (state == ViewState.loadComplete) {
      _refreshController.loadComplete();
    }

    return ListView.builder(
        itemExtent: 150,
        itemCount: movies.subjects.length,
        itemBuilder: (context, index) {
          MovieItem item = movies.subjects[index];
          return MovieCardView(
              item: item,
              onTap: () {
                RouterManager.navigateTo(context, RouterType.detail,
                    params:
                        'id=${item.id}&title=${Uri.encodeComponent(item.title)}');
              });
        });
  }
}
