
import 'package:douban/model/list_model.dart';
import 'package:douban/model/movie_model.dart';

import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';

import 'package:douban/view/movie_grid_view.dart';
import 'package:douban/view_model/home_view_model.dart';
import 'package:douban/view_model/viewState_view_model.dart';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatelessWidget {


  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel>(
      model: HomeViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
              title: Text(LocalizationManger.i18n(context, 'tab.home'))
          ),
          body: SmartRefresher(
            controller: _refreshController,
            header: RefreshHeader(),
            onRefresh: () {
              model.onRefresh();
            },
            child: _body(context, model),
          ),
        );
      }
    );
  }

  Widget _body(BuildContext context, HomeViewModel model) {

    final viewState = model.viewState;
    final list = model.movies;

    if (viewState == ViewState.onRefresh && model.refreshNoData) {
      return LoadingIndicator();
    }

    if (viewState == ViewState.refreshCompleted) {
      _refreshController.refreshCompleted();
    }

    if (viewState == ViewState.refreshError) {

      return ErrorView(model.message, () {
        model.onRefresh();
      });
    }

    if (viewState == ViewState.empty) {
      return ErrorView(LocalizationManger.i18n(context, 'refresh.empty'), () {
        model.onRefresh();
      });
    }

    return ListView.builder(
        itemCount: list.length ?? 0,
        itemBuilder: (context, index) {
          List<MovieGridItem> subjects = list[index].subjects
              .map((item) => MovieGridItem.from(item))
              .toList();

          return Container(
            height: 400,
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 10,
              children: subjects
                  .map((movie) {
                    return MovieGridView(
                  movie: movie,
                  onTap: () {
                    RouterManager.toMovie(context, RouterType.detail, movie.id, movie.title);
                  });
              })
                  .toList(),
            ),
          );

        });
  }

}

