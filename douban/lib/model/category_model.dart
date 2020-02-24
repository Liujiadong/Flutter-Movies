import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CategoryType {
  hot,
  coming,
  top250,
 // tv
}

class CategoryModel {

  String get title {
    switch (type) {
      case CategoryType.hot:
        return 'tab.hot';
      case CategoryType.top250:
        return 'tab.top250';
      case CategoryType.coming:
        return 'tab.coming';
//      case CategoryType.tv:
//        return 'tab.tv';
    }
  }

  Icon get icon {
    switch (type) {
      case CategoryType.hot:
        return Icon(Icons.movie);
      case CategoryType.coming:
        return Icon(Icons.fiber_new);
      case CategoryType.top250:
        return Icon(Icons.sort);
//      case CategoryType.tv:
//        return Icon(Icons.tv);
    }
  }

  CategoryType type;

  CategoryModel(this.type);

}