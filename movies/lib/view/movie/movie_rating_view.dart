import 'package:movies/model/movie_model.dart';
import 'package:movies/util/localization_manager.dart';
import 'package:flutter/material.dart';

import '../rating_view.dart';

class MovieRatingView extends StatelessWidget {

  final Movie movie;

  MovieRatingView(this.movie);

  Widget _textView(String text) {
    return Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(5)),
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RatingScoreView(movie.rating.value.toString(),
                    normalSize: 25, noneSize: 15, normalColor: Colors.white),
                RatingStarView(
                  movie.rating.fullCount,
                  Icon(Icons.star, size: 20, color: Colors.amberAccent),
                  movie.rating.emptyCount,
                  Icon(Icons.star_border, size: 20, color: Colors.amberAccent),
                  halfCount: movie.rating.halfCount,
                  halfIcon: Icon(Icons.star_half,
                      size: 20, color: Colors.amberAccent),
                ),
                Text(
                    '${movie.rating.count} ${LocalizationManger.i18n(context, 'movie.scored')}',
                    style: TextStyle(fontSize: 10, color: Colors.white))
              ],
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _textView(
                      '上映：${movie.released ? movie.pubdate : LocalizationManger.i18n(context, 'movie.unreleased')}'),
                  _textView('类型：${movie.genres}'),
                  _textView('片长：${movie.durations}'),
                  _textView('地区：${movie.countries}'),
                  _textView('语言：${movie.languages}'),
                ],
              ))
        ],
      ),
    );
  }
}