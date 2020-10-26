
import 'package:movies/util/localization_manager.dart';
import 'package:movies/util/util.dart';
import 'package:movies/view/provider_view.dart';

import 'package:movies/view_model/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:movies/view_model/language_view_model.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:movies/view/refresh_view.dart';

import 'error_view.dart';


class BaseTitleView extends StatelessWidget {

  final String text;

  BaseTitleView(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(LocalizationManger.i18n(context, text),
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      margin: EdgeInsets.only(bottom: 5),
    );
  }
}

class BaseRefreshView<T extends BaseViewModel> extends StatelessWidget {

  final _refreshController = RefreshController();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  final T viewModel;
  final String title;
  final bool enablePullUp;

  BaseRefreshView({
    this.title,
    this.viewModel,
    this.enablePullUp = false
  });

  @override
  Widget build(BuildContext context) {
    return ProviderView<T>(
        viewModel: viewModel,
        builder: (context, model, _) {
          return Scaffold(
            key: _scaffoldkey,
            appBar: AppBar(
                title: Consumer<LanguageViewModel>(
                  builder: (context, _, child) {
                    return Text(LocalizationManger.i18n(context, title));
                  }
                )
            ),
            body: SmartRefresher(
              controller: _refreshController,
              header: RefreshHeader(),
              footer: enablePullUp ? RefreshFooter():null,
              enablePullDown: !model.refreshNoData,
              enablePullUp: enablePullUp ? !model.refreshNoData : false,
              onRefresh: model.onRefresh,
              onLoading: enablePullUp ? model.onLoading : null,
              child: _refreshChild(context, viewModel),
            ),
          );
        }
    );
  }

  Widget _refreshChild(BuildContext context, T viewModel) {

    final state = viewModel.viewState;

    if (state == ViewState.onRefresh && viewModel.refreshNoData) {
      return RefreshCircularIndicator();
    }

    if (state == ViewState.refreshCompleted) {
      _refreshController.resetNoData();
      _refreshController.refreshCompleted();
    }

    if (state == ViewState.refreshError) {
      _refreshController.refreshFailed();
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

    if (state == ViewState.loadError) {
      _refreshController.loadFailed();
    }


    switch (state) {
      case ViewState.loadError:
      case ViewState.refreshError:
      case ViewState.empty:
        if (viewModel.refreshNoData) {
          return ErrorView(viewModel.message, onRefresh: viewModel.onRefresh);
        } else {
          showSnackBar(_scaffoldkey, viewModel.message);
          break;
        }
    }

    return bodyView;

  }

  Widget get bodyView {
    return RefreshCircularIndicator();
  }

}


Widget baseRefreshView (
    {@required BaseViewModel model,
    @required GlobalKey<ScaffoldState> scaffoldkey,
    @required RefreshController refreshController,
    @required Widget Function() builder}) {

  if (model.viewState == ViewState.onRefresh && model.refreshNoData) {


    return RefreshCircularIndicator();
  }

  if (model.viewState == ViewState.refreshCompleted) {
    refreshController.resetNoData();
    refreshController.refreshCompleted();
  }

  if (model.viewState == ViewState.refreshError) {
    refreshController.refreshFailed();
  }

  if (model.viewState == ViewState.onLoading) {
    refreshController.refreshToIdle();
  }

  if (model.viewState == ViewState.loadNoData) {
    refreshController.loadNoData();
  }

  if (model.viewState == ViewState.loadComplete) {
    refreshController.loadComplete();
  }

  if (model.viewState == ViewState.loadError) {
    refreshController.loadFailed();
  }

  switch (model.viewState) {
    case ViewState.loadError:
    case ViewState.refreshError:
    case ViewState.empty:
      if (model.refreshNoData) {
        return ErrorView(model.message, onRefresh: model.onRefresh);
      } else {
        showSnackBar(scaffoldkey, model.message);
        break;
      }
  }

  return builder();
}





