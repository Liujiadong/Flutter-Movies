import 'package:movies/model/comment_model.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/util/constant.dart';
import 'package:movies/util/router_manager.dart';
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

  MovieList list;
  String id;

  int _start = 0;

  MovieListViewModel(this.id) {
    onRefresh();
  }

  @override
  bool get isEmpty => list.subjects.isEmpty;

  @override
  bool get refreshNoData {
    if (list != null) {
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
    _start = list.subjects.length;
    super.onLoading();
  }

  @override
  refreshCompleted(json) {
    list =  MovieList.fromJson(json);
  }

  @override
  loadComplete(json) {
    final _list = MovieList.fromJson(json);
    list.subjects.addAll(_list.subjects);
  }

  @override
  bool get loadNoData => list.subjects.length >= list.total;

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

class MovieCommentViewModel extends BaseViewModel {

  CommentList list;

  String id;
  String path;

  int _start = 0;

  MovieCommentViewModel(this.id, this.path){
    onRefresh();
  }

  @override
  bool get isEmpty => list.subjects.isEmpty;

  @override
  String get api => Api.fetchMovie;

  @override
  String get extra => path;

  @override
  get data => {
    'id': id,
    'start': _start,
    'count': 10
  };

  @override
  bool get loadNoData => list.subjects.length >= list.total;

  @override
  bool get refreshNoData {
    if (list != null) {
      return isEmpty;
    }
    return true;
  }

  @override
  onRefresh() {
    _start = 0;
    super.onRefresh();
  }

  @override
  onLoading() {
    _start = list.subjects.length;
    super.onLoading();
  }

  @override
  refreshCompleted(json) {
    list = CommentList.fromJson(json);
  }

  @override
  loadComplete(json) {
    final _list = CommentList.fromJson(json);
    list.subjects.addAll(_list.subjects);
  }

}

class MoviePhotoViewModel extends BaseViewModel {
  //
  // Comments comments;
  //
  // String id;
  //
  // int _start = 0;
  //
  // MoviePhotoViewModel(this.id){
  //   onRefresh();
  // }
  //
  // @override
  // bool get isEmpty => comments.subjects.isEmpty;
  //
  // @override
  // String get api => Api.fetchMovie;
  //
  // @override
  // String get extra => path(RouterType.photos);
  //
  // @override
  // get data => {
  //   'id': id,
  //   'start': _start,
  //   'count': 10
  // };
  //
  // @override
  // bool get loadNoData => comments.subjects.length >= comments.total;
  //
  // @override
  // bool get refreshNoData {
  //   if (comments != null) {
  //     return isEmpty;
  //   }
  //   return true;
  // }
  //
  // @override
  // onRefresh() {
  //   _start = 0;
  //   super.onRefresh();
  // }
  //
  // @override
  // onLoading() {
  //   _start = comments.subjects.length;
  //   super.onLoading();
  // }
  //
  // @override
  // refreshCompleted(json) {
  //   comments = Comments.fromJson(json);
  // }
  //
  // @override
  // loadComplete(json) {
  //   final _comments = Comments.fromJson(json);
  //   comments.subjects.addAll(_comments.subjects);
  // }

}