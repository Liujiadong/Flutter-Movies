
import 'package:douban/util/constant.dart';

import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';
import 'package:douban/view/movie_card_view.dart';
import 'package:douban/view/movie_grid_view.dart';

import 'package:douban/view_model/viewState_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _refreshController = RefreshController();
  bool _canScroll = true;

  @override
  Widget build(BuildContext context) {

    return Placeholder(color: HexToColor('#657271'));

    // return ProviderWidget<CategoryViewModel>(
    //     model: CategoryViewModel(),
    //     builder: (context, model, _) {
    //       return Scaffold(
    //           appBar: AppBar(
    //             title: Text(LocalizationManger.i18n(context, model.title)),
    //           //  actions: <Widget>[_searchDialog],
    //           ),
    //          // drawer: _drawer,
    //           body: SmartRefresher(
    //             controller: _refreshController,
    //             header: RefreshHeader(),
    //             footer: RefreshFooter(),
    //             enablePullUp: model.movies != null,
    //             onRefresh: () async {
    //               model.onRefresh();
    //             },
    //             onLoading: () async {
    //               model.onLoading();
    //             },
    //             child: _body(model),
    //           ));
    //     });
  }


  //
  // Widget _body(CategoryViewModel model) {
  //   final viewState = model.viewState;
  //   final movies = model.movies;
  //
  //   Widget _body;
  //
  //   switch (viewState) {
  //     case ViewState.onRefresh:
  //       _canScroll = true;
  //       _refreshController.resetNoData();
  //       _body = ListLoadingView();
  //       break;
  //     case ViewState.refreshError:
  //       _refreshController.refreshFailed();
  //       _body = ErrorView(model.message, () {
  //         model.onRefresh();
  //       });
  //       break;
  //     case ViewState.refreshCompleted:
  //       if (_refreshController.position != null && _canScroll) {
  //         _refreshController.position.jumpTo(0.0);
  //       }
  //       _refreshController.refreshCompleted();
  //       break;
  //     case ViewState.onLoading:
  //       _refreshController.refreshToIdle();
  //       break;
  //     case ViewState.loadNoData:
  //       _refreshController.loadNoData();
  //       break;
  //     case ViewState.loadComplete:
  //       _refreshController.loadComplete();
  //       break;
  //     case ViewState.loadError:
  //       _refreshController.loadFailed();
  //       //Fluttertoast.showToast(msg: model.message);
  //       break;
  //     default:
  //       _body = Text('Error');
  //   }
  //
  //   if (_body != null) {
  //     return _body;
  //   }
  //
  //   return model.type == CategoryType.top250
  //       ? GridView.count(
  //           crossAxisCount: 3,
  //           childAspectRatio: 2 / 3,
  //           children: movies.subjects.map((v) {
  //             return MovieGridView(
  //                 item: v,
  //                 onTap: () {
  //                   _push(v.id, v.title);
  //                 });
  //           }).toList(),
  //         )
  //       : ListView.builder(
  //           itemExtent: 150,
  //           itemCount: movies.subjects.length,
  //           itemBuilder: (context, index) {
  //             final item = movies.subjects[index];
  //             return MovieCardView(
  //                 item: item,
  //                 onTap: () {
  //                   _push(item.id, item.title);
  //                 });
  //           });
  // }


  // _push(String id, String title) {
  //   _canScroll = false;
  //   RouterManager.navigateTo(context, RouterType.detail, params: 'id=$id&title=${Uri.encodeComponent(title)}');
  // }

}
