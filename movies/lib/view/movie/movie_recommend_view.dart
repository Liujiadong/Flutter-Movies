import 'package:movies/model/movie_model.dart';
import 'package:movies/util/constant.dart';
import 'package:movies/util/localization_manager.dart';
import 'package:movies/util/provider_manager.dart';
import 'package:movies/util/router_manager.dart';
import 'package:movies/view/base_view.dart';
import 'package:movies/view/error_view.dart';
import 'package:movies/view/movie/movie_grid_item_view.dart';
import 'package:movies/view_model/movie_view_model.dart';
import 'package:movies/view_model/base_view_model.dart';
import 'package:flutter/material.dart';

class MovieRecommendView extends StatelessWidget {
  String id;

  MovieRecommendView(this.id);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieRecommendedViewModel>(
      model: MovieRecommendedViewModel(id),
      builder: (context, model, _) {
        return SizedBox(
            child: Column(
              children: [
                SizedBox(height: 15),
                Text(LocalizationManger.i18n(context, 'movie.recommended'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  height: screenWidth(context),
                  child: _body(context, model),
                )
              ],
            ));
      },
    );
  }

  Widget _body(BuildContext context, MovieRecommendedViewModel model) {
    final state = model.viewState;
    List<MovieGridItem> movies = model.movies;


    if (state == ViewState.onRefresh) {
      return CircularIndicator();
    }

    if (state == ViewState.empty || state == ViewState.refreshError) {
      return ErrorView(model.message, onRefresh: model.onRefresh);
    }

    return GridView.count(
      padding: EdgeInsets.all(10),
      crossAxisCount: 3,
      childAspectRatio: 2 / 3,
      children: movies.map((item) {
        return MovieGridItemView(
            item: item,
            onTap: () {
              RouterManager.toMovie(
                  context, RouterType.detail, item.id, item.title);
            });
      }).toList(),
    );
  }
}
