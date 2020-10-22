import 'package:movies/model/movie_model.dart';
import 'package:movies/util/router_manager.dart';
import 'package:movies/view/base_view.dart';
import 'package:movies/view/list_item_view.dart';
import 'package:movies/view/provider_view.dart';
import 'package:movies/view/refresh_view.dart';
import 'package:movies/view_model/movie_view_model.dart';


import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListView extends StatelessWidget {
  String id, title;

  RankListView(this.id, this.title);

  final _refreshController = RefreshController();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ProviderView<MovieListViewModel>(
      viewModel: MovieListViewModel(id),
      builder: (context, model, _) {
        return Scaffold(
            key: _scaffoldkey,
            appBar: AppBar(title: Text(title)),
            body: SmartRefresher(
              controller: _refreshController,
              header: RefreshHeader(),
              footer: RefreshFooter(),
              enablePullUp: !model.refreshNoData,
              enablePullDown: !model.refreshNoData,
              onRefresh: model.onRefresh,
              onLoading: model.onLoading,
              child: _body(context, model),
            ));
      },
    );
  }

  Widget _body(BuildContext context, MovieListViewModel model) {

    return baseRefreshView(
        model: model,
        scaffoldkey: _scaffoldkey,
        refreshController: _refreshController,
        builder: () {

          final list = model.list;

          return ListView.builder(
              itemExtent: 150,
              itemCount: list.subjects.length,
              itemBuilder: (context, index) {
                MovieListItem item = list.subjects[index];
                return ListItemView(item,() {
                      RouterManager.toMovie(context,
                          RouterType.detail,
                          item.id,
                          item.title);
                    });
              });

        }
    );

  }
}
