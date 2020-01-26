import 'package:douban/model/category_model.dart';
import 'package:douban/model/movie_model.dart';
import 'package:douban/moudule/home/drawer_view.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';
import 'package:douban/view/list_loading_view.dart';
import 'package:douban/view/movie_card_view.dart';
import 'package:douban/view/movie_grid_view.dart';
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

  @override
  Widget build(BuildContext context) {

    return ProviderWidget<CategoryViewModel>(
        model: CategoryViewModel(),
        onModelReady: (category) {
          category.onRefresh();
        },
        builder: (context, model, _) {

          return Scaffold(
              appBar: AppBar(title: Text(LocalizationManger.i18n(context, model.title))),
              drawer: DrawerView(),
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
              )
          );
        }
    );

  }

  Widget _body(CategoryViewModel model) {

    final viewState = model.viewState;
    final movies = model.movies;

    Widget _body;

    switch (viewState) {
      case ViewState.onRefresh:
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
        if (refreshController.position != null) {
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

    return model.type == CategoryType.top250 ?
    GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2/3,
      children: movies.subjects.map((v) {
        return MovieGridView(movie: v, onTap: (context) {
          navigateTo(context, v);
        });
      }).toList(),
    ):
    ListView.builder(
        itemExtent: 150,
        itemCount: movies.subjects.length,
        itemBuilder: (context, index) {
          final _movie =  movies.subjects[index];
          return MovieCardView(movie: _movie, onTap: (context) {
            navigateTo(context, _movie);
          });
        });

  }

  navigateTo(BuildContext context, MovieModel movie) {
    RouterManager.navigateTo(context, RouterType.detail,
        params: 'id=${movie.id}');
  }
}


