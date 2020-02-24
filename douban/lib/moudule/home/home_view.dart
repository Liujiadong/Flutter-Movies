import 'package:douban/model/category_model.dart';
import 'package:douban/moudule/home/drawer_view.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';
import 'package:douban/view/list_loading_view.dart';
import 'package:douban/view/movie_card_view.dart';
import 'package:douban/view/movie_grid_view.dart';
import 'package:douban/view/movie_web_view.dart';
import 'package:douban/view_model/category_view_model.dart';
import 'package:douban/view_model/viewState_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final refreshController = RefreshController();
  var canScroll = true;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CategoryViewModel>(
        model: CategoryViewModel(),
        builder: (context, model, _) {
          return Scaffold(
              appBar: AppBar(
                title: Text(LocalizationManger.i18n(context, model.title)),
                actions: <Widget>[_searchDialog],
              ),
              drawer: _drawer,
              body: SmartRefresher(
                controller: refreshController,
                header: RefreshHeader(),
                footer: RefreshFooter(),
                enablePullUp: model.movies != null,
                onRefresh: () async {
                  model.onRefresh();
                },
                onLoading: () async {
                  model.onLoading();
                },
                child: _body(model),
              ));
        });
  }


  Widget get _searchDialog {
    return SizedBox(
      width: 50,
      child: InkWell(
        child: Icon(Icons.search),
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: TextField(
                    onSubmitted: (text) {
                      _openWeb(text, ConsString.query_movie + text);
                    },
                  ),
                );
              });
        },
      ),
    );
  }

  Widget get _drawer {

    return DrawerView(onTap: (title, url) {
      _openWeb(title, url);
    }, onPressed: () {
      _navigateTo(RouterType.settings, canPop: true);
    });
  }


  Widget _body(CategoryViewModel model) {
    final viewState = model.viewState;
    final movies = model.movies;

    Widget _body;

    switch (viewState) {
      case ViewState.onRefresh:
        canScroll = true;
        refreshController.resetNoData();
        _body = ListLoadingView();
        break;
      case ViewState.refreshError:
        refreshController.refreshFailed();
        _body = ErrorView(model.message, () {
          model.onRefresh();
        });
        break;
      case ViewState.refreshCompleted:
        if (refreshController.position != null && canScroll) {
          refreshController.position.jumpTo(0.0);
        }
        refreshController.refreshCompleted();
        break;
      case ViewState.onLoading:
        refreshController.refreshToIdle();
        break;
      case ViewState.loadNoData:
        refreshController.loadNoData();
        break;
      case ViewState.loadComplete:
        refreshController.loadComplete();
        break;
      case ViewState.loadError:
        refreshController.loadFailed();
        Fluttertoast.showToast(msg: model.message);
        break;
      default:
        _body = Text('Error');
    }

    if (_body != null) {
      return _body;
    }

    return model.type == CategoryType.top250
        ? GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 2 / 3,
            children: movies.subjects.map((v) {
              return MovieGridView(
                  movie: v,
                  onTap: () {
                    _navigateTo(RouterType.detail, params: 'id=${v.id}');
                  });
            }).toList(),
          )
        : ListView.builder(
            itemExtent: 150,
            itemCount: movies.subjects.length,
            itemBuilder: (context, index) {
              final _movie = movies.subjects[index];
              return MovieCardView(
                  movie: _movie,
                  onTap: () {
                    _navigateTo(RouterType.detail, params: 'id=${_movie.id}');
                  });
            });
  }

  _openWeb(String title, String url) {
    canScroll = false;
    RouterManager.pop(context);
    MovieWebView.open(context, url, title: title);
  }


  _navigateTo(RouterType type, {String params = '', bool canPop = false}) {
    canScroll = false;
    if (canPop) {
      RouterManager.pop(context);
    }
    RouterManager.navigateTo(context, type, params: params);
  }
}
