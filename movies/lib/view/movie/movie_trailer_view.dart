import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/util/localization_manager.dart';
import 'package:movies/view/player_view.dart';
import 'package:flutter/material.dart';

import '../base_view.dart';


class MovieTrailerView extends StatelessWidget {

  final Movie movie;

  MovieTrailerView(this.movie);

  @override
  Widget build(BuildContext context) {

    final trailer = movie.trailer;
    final title = movie.title;

    if (trailer != null) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BaseTitleView('movie.trailers'),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 180,
                  child: Container(
                    child: GestureDetector(
                      onTap: () {
                        PlayerView.open(context, trailer.video, title: '$title(${LocalizationManger.i18n(context, 'movie.trailers')})');
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
                  )
              )
            ],
          ));
    }
    return SizedBox();

  }

}
