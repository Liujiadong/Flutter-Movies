import 'package:dio/dio.dart';

import 'package:movies/model/movie_model.dart';
import 'package:movies/util/constant.dart';
import 'package:movies/util/network_manager.dart';


import 'base_view_model.dart';

class HomeViewModel extends BaseViewModel {

  List<MovieList> lists;

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
      lists = result;
      setViewState(ViewState.refreshCompleted);
      if (isEmpty) {
        setViewState(ViewState.empty, message:'refresh.empty');
      }
    }).catchError((error) {
      setViewState(ViewState.refreshError, message: error.message);
    });
  }

  @override
  bool get refreshNoData {
    if (lists != null) {
      return isEmpty;
    }
    return true;
  }

  @override
  bool get isEmpty => lists.isEmpty;

  Future<MovieList> _fetch(String extra) async {
    Response response = await NetworkManager.get(Api.fetchMovieList,
        extra: Api.itemsPath(extra),
        data: {'start': 0, 'count': 6}
        );
    return MovieList.fromJson(response.data);
  }

}
