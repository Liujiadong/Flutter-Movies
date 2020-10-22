import 'package:movies/model/movie_model.dart';
import 'package:movies/util/router_manager.dart';
import 'package:movies/view/base_view.dart';
import 'package:movies/view/home_item_view.dart';
import 'package:movies/view_model/home_view_model.dart';
import 'package:flutter/material.dart';


class HomeView extends BaseRefreshView<HomeViewModel>  {

  HomeView() : super('tab.home', HomeViewModel());

  @override
  Widget get bodyView {

    final lists = viewModel.lists;
    return ListView.builder(
        itemCount: lists.length ?? 0,
        itemBuilder: (context, index) {
          MovieList list = lists[index];

          return HomeItemView(list, onTitleTap: () {
            RouterManager.toMovie(
                context, RouterType.rank_list, list.id, list.name);
          }, onItemTap: (item) {
            RouterManager.toMovie(
                context, RouterType.detail, item.id, item.title);
          });

        });
  }


}
