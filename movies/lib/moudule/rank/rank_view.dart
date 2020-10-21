import 'package:movies/model/rank_model.dart';
import 'package:movies/util/localization_manager.dart';
import 'package:movies/util/provider_manager.dart';
import 'package:movies/util/router_manager.dart';
import 'package:movies/view/base_view.dart';
import 'package:movies/view/rank_item_view.dart';
import 'package:movies/view_model/rank_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankView extends StatelessWidget {

  final _refreshController = RefreshController();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<RankViewModel>(
        model: RankViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            key: _scaffoldkey,
            appBar: AppBar(
                title: Text(LocalizationManger.i18n(context, 'tab.rank'))),
            body: SmartRefresher(
              controller: _refreshController,
              header: RefreshHeader(),
              enablePullDown: !model.refreshNoData,
              onRefresh: model.onRefresh,
              child: _body(context, model),
            ),
          );
        });
  }

  Widget _body(BuildContext context, RankViewModel model) {

    return baseRefreshView(
        model: model,
        scaffoldkey: _scaffoldkey,
        refreshController: _refreshController,
        builder: () {

          final list = model.list;

          return ListView.builder(
              itemCount: list.subjects.length ?? 0,
              itemBuilder: (context, index) {
                RankListItem item = list.subjects[index];

                return Column(
                  children: [
                    SizedBox(height: 10),
                    InkWell(
                      child: RankItemView(item),
                      onTap: () {
                        RouterManager.toMovie(context, RouterType.rank_list,
                            item.id, item.name);
                      },
                    ),
                  ],
                );
              });

        });
  }

}
