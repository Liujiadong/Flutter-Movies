import 'package:dio/dio.dart';
import 'package:douban/model/category_model.dart';
import 'package:douban/model/list_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/network_manager.dart';
import 'package:douban/view_model/viewState_view_model.dart';
import 'package:flutter/material.dart';


class CategoryViewModel extends ViewStateViewModel {

  CategoryType _type;
  
  String get title => CategoryModel(_type).title;
  Icon get icon => CategoryModel(_type).icon;

  Movies movies;

  int get _count {
    switch(_type) {
      case CategoryType.hot:
        return 8;
      case CategoryType.top250:
        return 12;
      case CategoryType.coming:
        return 8;
    }
  }

  String get _path {
    switch(_type) {
      case CategoryType.hot:
        return Api.fetchHot;
      case CategoryType.top250:
        return Api.fetchTop250;
      case CategoryType.coming:
        return Api.fetchComing;  
    }
  }

  set type(CategoryType type) {
    _type = type;
    onRefresh();
    notifyListeners();
  }

  get type => _type;

  CategoryViewModel() {
    _type = CategoryType.values.first;
    onRefresh();
  }

  Future<Response> _fetch(int start) async {

    final response = NetworkManager.get(_path, data: {
      "start": start,
      "count": _count,
    });

    return response;

  }

  onRefresh() {
    setViewState(ViewState.onRefresh);
    _fetch(0).then((response) {
      final _movies = Movies.fromJson(response.data);
      movies =  _movies;
      setViewState(ViewState.refreshCompleted);
    }, onError:(error) {
      setViewState(ViewState.refreshError, message: error.message);
    });
  }


  onLoading() {

    if (movies.subjects.length >= movies.total) {
      setViewState(ViewState.loadNoData);
    } else {
      setViewState(ViewState.onLoading);
      _fetch(movies.subjects.length).then((response) {
        final _movies = Movies.fromJson(response.data);
        movies.subjects.addAll(_movies.subjects);
        setViewState(ViewState.loadComplete);
      }, onError:(error) {
        setViewState(ViewState.loadError, message: error.message);
      });
    }

  }


}