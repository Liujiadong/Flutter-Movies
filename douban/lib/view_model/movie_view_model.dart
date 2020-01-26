import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/movie_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/network_manager.dart';
import 'package:douban/view_model/viewState_view_model.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieViewModel extends ViewStateViewModel {


  MovieModel movie;
  Color coverColor = ConstColor.theme;
  String title = '';

  String id;

  MovieViewModel(this.id) {
    fetch();
  }

  fetch() {
    setViewState(ViewState.onRefresh);
    NetworkManager.get(Api.fetchMovie, data: {'id': id}).then((response) {
      movie = MovieModel.fromJson(response.data);
      title = movie.title;
      //_fetchColor(movie.smallImage);
      setViewState(ViewState.refreshCompleted);
    }, onError:(error) {
      setViewState(ViewState.refreshError, message: error.message);
    });
  }

  _fetchColor(String cover) async {

    setViewState(ViewState.onLoading);
    PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(cover));
    if (paletteGenerator.paletteColors.length > 0) {
      coverColor = paletteGenerator.paletteColors.last.color;
    }
    setViewState(ViewState.loadComplete);
  }

}