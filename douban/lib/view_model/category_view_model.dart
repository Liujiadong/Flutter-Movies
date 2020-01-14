import 'package:douban/model/category_model.dart';
import 'package:douban/model/list_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/network_manager.dart';
import 'package:flutter/material.dart';


class CategoryViewModel extends ChangeNotifier {

  CategoryType _type = CategoryType.values.first;

  String get title => CategoryModel(_type).title;
  Icon get icon => CategoryModel(_type).icon;

  Movies movies;

  String get _path {
    switch(_type) {
      case CategoryType.hot:
        return Api.fetchHot;
      case CategoryType.latest:
        return Api.fetchNew;
      case CategoryType.coming:
        return Api.fetchComing;  
    }
  } 
  
  
  setType(CategoryType type) {
    _type = type;
    fetchData();
    notifyListeners();
  }

  fetchData({start = 0, count = 6}) async {

    final response = await NetworkManager.get(_path, data: {
      "start": start,
      "count": count,
    });

    print(response.statusMessage);
    movies =  Movies.fromJson(response.data);

  }




}