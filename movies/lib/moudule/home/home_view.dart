

import 'package:movies/model/movie_model.dart';
import 'package:movies/util/constant.dart';

import 'package:movies/util/localization_manager.dart';
import 'package:movies/util/provider_manager.dart';
import 'package:movies/util/router_manager.dart';
import 'package:movies/view/base_view.dart';
import 'package:movies/view/movie/movie_grid_item_view.dart';

import 'package:movies/view_model/home_view_model.dart';


import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatelessWidget {


  final _refreshController = RefreshController();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel>(
      model: HomeViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          key: _scaffoldkey,
          appBar: AppBar(
              title: Text(LocalizationManger.i18n(context, 'tab.home'))
          ),
          body: SmartRefresher(
            controller: _refreshController,
            header: RefreshHeader(),
            enablePullDown: !model.refreshNoData,
            onRefresh: model.onRefresh,
            child: _body(context, model),
          ),
        );
      }
    );
  }

  Widget _body(BuildContext context, HomeViewModel model) {

    return baseRefreshView(
      model: model,
      scaffoldkey: _scaffoldkey,
      refreshController: _refreshController,
      builder: () {

        final lists = model.lists;

        return ListView.builder(
            itemCount: lists.length ?? 0,
            itemBuilder: (context, index) {

              MovieList list = lists[index];
              List<MovieGridItem> subjects = list.subjects
                  .map((item) => MovieGridItem.from(item))
                  .toList();

              return Column(
                  children: [
                    ListTile(
                        title: Text(list.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        trailing: Icon(Icons.chevron_right, color: ConsColor.theme),
                        onTap: () {
                          RouterManager.toMovie(context, RouterType.rank_list, list.id, list.name);
                        }),
                    Container(
                      height: screenWidth(context) - 20,
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        childAspectRatio: 2/3,
                        crossAxisCount: 3,
                        children: subjects
                            .map((item) {
                          return MovieGridItemView(
                              item: item,
                              onTap: () {
                                RouterManager.toMovie(context, RouterType.detail, item.id, item.title);
                              });
                        }).toList(),
                      ),
                    )
                  ]);

            });
      }
    );


  }

}

