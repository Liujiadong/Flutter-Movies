import 'package:movies/model/movie_model.dart';
import 'package:movies/util/constant.dart';
import 'package:movies/util/localization_manager.dart';
import 'package:movies/view_model/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'error_view.dart';



class RefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
        failedIcon: Icon(Icons.error, color: ConsColor.theme),
        completeIcon: Icon(Icons.done, color: ConsColor.theme),
        idleIcon: Icon(Icons.arrow_downward, color: ConsColor.theme),
        releaseIcon: Icon(Icons.refresh, color: ConsColor.theme),
        refreshingIcon: SizedBox(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ConsColor.theme),
              strokeWidth: 3),
          height: 15.0,
          width: 15.0,
        ),
        idleText: '',
        refreshingText: '',
        releaseText: '',
        completeText: '',
        failedText: LocalizationManger.i18n(context, 'refresh.refreshFailed'));
  }
}

class RefreshFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      loadingIcon: SizedBox(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ConsColor.theme),
            strokeWidth: 3),
        height: 15.0,
        width: 15.0,
      ),
      canLoadingIcon: Icon(Icons.autorenew, color: ConsColor.theme),
      failedIcon: Icon(Icons.error, color: ConsColor.theme),
      idleIcon: Icon(Icons.arrow_upward, color: ConsColor.theme),
      idleText: '',
      loadingText: '',
      canLoadingText: '',
      noDataText: LocalizationManger.i18n(context, 'refresh.noMore'),
      failedText: LocalizationManger.i18n(context, 'refresh.loadFailed'),
    );
  }
}

class CircularIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 150),
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ConsColor.theme)),
        ));
  }
}

Widget baseRefreshView (
    {@required BaseViewModel model,
    @required GlobalKey<ScaffoldState> scaffoldkey,
    @required RefreshController refreshController,
    @required Widget Function() builder}) {

  if (model.viewState == ViewState.onRefresh && model.refreshNoData) {
    return CircularIndicator();
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

showSnackBar(GlobalKey<ScaffoldState> key, String text) {
  if (key.currentState != null) {
    key.currentState.showSnackBar(
        SnackBar(content: Text(text), backgroundColor: ConsColor.theme)
    );
  }
}
