import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/util/localization_manager.dart';
import 'package:movies/view/movie_player_view.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class MovieTrailerView extends StatelessWidget {


  EdgeInsetsGeometry margin;
  double height;

  MovieTrailer trailer;
  String title;

  MovieTrailerView(this.trailer, this.title,
      {this.margin = const EdgeInsets.only(top: 5), this.height = 180});

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: margin,
        height: height,
        child: _videoWidget(context)
    );
  }

  Widget _videoWidget(BuildContext context) {

    return Container(
      child: GestureDetector(
        onTap: () {
          MoviePlayerView.open(context, trailer.video, title: '$title${(LocalizationManger.i18n(context, 'movie.trailers'))}}');
        },
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            CachedNetworkImage(imageUrl: trailer.cover, fit: BoxFit.cover),
            Icon(Icons.play_circle_filled, size: 50, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
