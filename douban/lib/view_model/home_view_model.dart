import 'package:dio/dio.dart';
import 'package:douban/model/list_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/network_manager.dart';
import 'package:douban/view_model/viewState_view_model.dart';

import 'base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  List<Movies> movies;

  HomeViewModel() {
    onRefresh();
  }

  @override
  onRefresh() {
    setViewState(ViewState.onRefresh);
    Future.wait([
      _fetch('movie_showing'),
      _fetch('movie_hot_gaia'),
      _fetch('tv_hot')
    ]).then((result) {
      movies = result;
      setViewState(ViewState.refreshCompleted);
      if (isEmpty) {
        setViewState(ViewState.empty);
      }
    }).catchError((error) {
      setViewState(ViewState.refreshError, message: error.message);
    });
  }

  @override
  // TODO: implement refreshNoData
  bool get refreshNoData {
    if (movies != null) {
      return isEmpty;
    }
    return true;
  }

  @override
  bool get isEmpty => movies.isEmpty;

  Future<Movies> _fetch(String extra) async {
    Response response = await NetworkManager.get(Api.fetchMovieList,
        extra: Api.itemsPath(extra), data: {'start': 0, 'count': 6});
    return Movies.fromJson(response.data);
  }
}
