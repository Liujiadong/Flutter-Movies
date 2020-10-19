import 'package:douban/model/list_model.dart';
import 'package:douban/model/movie_model.dart';
import 'package:douban/util/constant.dart';
import 'package:flutter/material.dart';

import 'base_view_model.dart';

class MovieViewModel extends BaseViewModel {


  Movie movie;
  Color color;

  String id;

  MovieViewModel(this.id) {
    onRefresh();
  }

  @override
  get data => {'id': id};

  @override
  String get api => Api.fetchMovie;

  @override
  refreshCompleted(json) {
    movie = Movie.fromJson(json);
    color = HexToColor(movie.color.primary);
  }

}


class MovieListViewModel extends BaseViewModel {

  Movies movies;
  String id;

  int _start = 0;

  MovieListViewModel(this.id) {
    onRefresh();
  }

  @override
  bool get isEmpty => movies.subjects.isEmpty;

  @override
  bool get refreshNoData {
    if (movies != null) {
      return isEmpty;
    }
    return true;
  }

  @override
  String get api => Api.fetchMovieList;

  @override
  String get extra => Api.itemsPath(id);

  @override
  get data => {
    'start': _start,
    'count': 10
  };


  @override
  onRefresh() {
    _start = 0;
    super.onRefresh();
  }

  @override
  onLoading() {
    _start = movies.subjects.length;
    super.onLoading();
  }

  @override
  refreshCompleted(json) {
    movies =  Movies.fromJson(json);
  }

  @override
  loadComplete(json) {
    final _movies = Movies.fromJson(json);
    movies.subjects.addAll(_movies.subjects);
  }

  @override
  bool get loadNoData => movies.subjects.length >= movies.total;

}


class MovieRecommendedViewModel extends BaseViewModel {

  List<MovieGridItem> movies;

  String id;

  MovieRecommendedViewModel(this.id) {
    onRefresh();
  }

  @override
  get data => {'id': id};

  @override
  String get api => Api.fetchMovie;

  @override
  String get extra => '/recommendations';

  @override
  refreshCompleted(json) {
    movies = (json as List).map((item) => MovieGridItem.fromJson(item)).toList();
  }

  @override
  bool get isEmpty => movies.isEmpty;

}