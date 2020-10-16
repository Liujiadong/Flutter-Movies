import 'package:douban/model/movie_model.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/view/base_view.dart';
import 'package:douban/view/movie_grid_view.dart';
import 'package:douban/view_model/movie_view_model.dart';
import 'package:douban/view_model/viewState_view_model.dart';
import 'package:flutter/material.dart';
class RecommendView extends StatelessWidget {

  String id;

  RecommendView(this.id);

  @override
  Widget build(BuildContext context) {

    return ProviderWidget<MovieRecommendedViewModel>(
      model: MovieRecommendedViewModel(id),
      builder: (context, model, _) {
        return Column(
          children: [
            SizedBox(height: 20),
            Text(LocalizationManger.i18n(context, 'movie.recommended'), style: TextStyle(fontSize: 18)),
            _body(context, model)
          ],
        );
      },
    );
  }


  Widget _body(BuildContext context,MovieRecommendedViewModel model) {

    final state = model.viewState;
    List<MovieItem> items = model.items;

    if (state == ViewState.onRefresh) {
      return LoadingIndicator();
    }

    if (state == ViewState.empty) {
      return ErrorView(LocalizationManger.i18n(context, 'refresh.empty'), () {
        model.onRefresh();
      });
    }

    if (state == ViewState.refreshError) {
      return ErrorView(model.message, () {
        model.onRefresh();
      });
    }

    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 1,
      childAspectRatio: 3 / 2,
      mainAxisSpacing: 10,
      children: items
          .map((item) { return MovieGridView(item: item);})
          .toList(),
    );

  }

}
