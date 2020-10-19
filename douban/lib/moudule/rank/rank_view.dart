import 'package:douban/model/rank_model.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';
import 'package:douban/view/rank_item_view.dart';
import 'package:douban/view_model/rank_view_model.dart';
import 'package:douban/view_model/viewState_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankView extends StatelessWidget {


  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {

    return ProviderWidget<RankViewModel>(
      model: RankViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(title: Text(LocalizationManger.i18n(context, 'tab.rank'))),
          body: SmartRefresher(
            controller: _refreshController,
            header: RefreshHeader(),
            onRefresh: () async {
              model.onRefresh();
            },
            child: _body(context, model),
          ),
        );
      }
    );
  }

  Widget _body(BuildContext context, RankViewModel model) {

    final viewState = model.viewState;
    final ranks = model.ranks;

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
        itemCount: ranks.subjects.length ?? 0,
        itemBuilder: (context, index) {
          RankItem _rankItem =  ranks.subjects[index];

          return Column(
            children: [
              SizedBox(height: 10),
              InkWell(
                child: RankItemView(_rankItem),
                onTap: () {
                  RouterManager.toMovie(context, RouterType.rank_list, _rankItem.id, _rankItem.name);
                },
              ),
            ],
          );

        });


  }

}
