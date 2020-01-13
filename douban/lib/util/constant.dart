import 'package:flutter/material.dart';


class ConstColor {
  static const theme = Color.fromRGBO(0, 148, 50, 1.0);
}

class Api {
  static const fetchHot = '/v2/movie/in_theaters';
  static const fetchComing = '/v2/movie/coming_soon';
  static const fetchTop250 = '/v2/movie/top250';
  static const fetchNew = '/v2/movie/new_movies';
}