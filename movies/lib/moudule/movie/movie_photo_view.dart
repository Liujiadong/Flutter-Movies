import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:movies/view/base_view.dart';
import 'package:movies/view/gallery_view.dart';
import 'package:movies/view_model/movie_view_model.dart';


class MoviePhotoView extends BaseRefreshView<MoviePhotoViewModel> {


  MoviePhotoView(id)
      : super(
      title: 'movie.photos',
      viewModel: MoviePhotoViewModel(id),
      enablePullUp: true);



  @override
  Widget get bodyView {

    final list = viewModel.list;

    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: list.subjects.length ?? 0,
      itemBuilder: (BuildContext context, int index) {

        final item = list.subjects[index];

        return GestureDetector(
          onTap: () {
            GalleryView.open(context, list.items, index);
          },
          child: CachedNetworkImage(imageUrl: item.s.url, fit: BoxFit.cover),
        );
      },
      staggeredTileBuilder: (index) {
        return StaggeredTile.fit(2);
      },
      // mainAxisSpacing: 0.5,
      // crossAxisSpacing: 0.5,
    );

  }
}
