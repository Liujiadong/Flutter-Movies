import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CategoryType {
  hot,
  latest,
  coming,
}

class CategoryModel {

  String get title {
    switch (type) {
      case CategoryType.hot:
        return 'tab.hot';
      case CategoryType.latest:
        return 'tab.new';
      case CategoryType.coming:
        return 'tab.coming';
    }
  }

  Icon get icon {
    switch (type) {
      case CategoryType.hot:
        return Icon(Icons.movie);
      case CategoryType.latest:
        return Icon(Icons.fiber_new);
      case CategoryType.coming:
        return Icon(Icons.sort);
    }
  }

  CategoryType type;

  CategoryModel(this.type);

}