import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/movie_model.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/view_model/language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class MovieCardView extends StatelessWidget {
  MovieModel movie;
  GestureTapCallback onTap;
  
  MovieCardView({
    this.movie,
    this.onTap
  });


  BuildContext _context;

  @override
  Widget build(BuildContext context) {

    _context = context;

    return Card(
        child: InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          children: <Widget>[_buildImage, _buildTitle, _buildRating],
        ),
      ),
    ));
  }

  get _buildImage {
    return Container(
        width: 80,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(3.0),
            image: DecorationImage(
                image: CachedNetworkImageProvider(movie.largeImage),
                fit: BoxFit.fill)));
  }

  get _buildTitle {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              "${movie.mainland_pubdate} ${movie.durations.isNotEmpty ? "/ ${movie.durations.first}" : ""}",
              maxLines: 1,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            "${movie.genres.join(" / ")}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          Text(
            "${movie.directors.map((staff) => staff.name).join(" / ")}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13),
          ),
          Text(
            "${movie.casts.map((c) => c.name).join(" / ")}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  get _buildRating {
    return Container(
      width: 80,
      child: Column(children: <Widget>[
        RatingLabel(movie.rating.average.toString(),
            normalSize: 24, noneSize: 15, noneColor: Colors.grey),
        RatingStar(
            movie.rating.fullCount,
            Icon(Icons.star, size: 16, color: Colors.amberAccent),
            movie.rating.emptyCount,
            Icon(Icons.star_border, size: 16, color: Colors.amberAccent),
            halfCount: movie.rating.halfCount,
            halfIcon:
                Icon(Icons.star_half, size: 16, color: Colors.amberAccent)),
        Consumer<LanguageViewModel>(builder: (context, _, child) {
          return Text(
            "${movie.collect_count}${LocalizationManger.i18n(_context, 'movie.seen')}",
            style: TextStyle(
              fontSize: 9,
            ),
          );
        })

      ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly),
    );
  }
}
