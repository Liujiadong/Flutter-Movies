import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/movie_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/view_model/language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_view.dart';

class MovieCardView extends StatelessWidget {

  MovieItem item;
  GestureTapCallback onTap;
  
  MovieCardView({
    this.item,
    this.onTap
  });


  bool get _isMovieItem => item.directors != null;

  @override
  Widget build(BuildContext context) {

    return Card(
        child: InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          children: <Widget>[_buildImage, _buildTitle, _buildRating(context)],
        ),
      ),
    ));
  }

  get _buildImage {
    return Container(
        width: 80,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            image: DecorationImage(
                image: CachedNetworkImageProvider(item.cover),
                fit: BoxFit.fill)));
  }

  get _buildTitle {
    return Expanded(
      child: Column(
        mainAxisAlignment: _isMovieItem ? MainAxisAlignment.start:MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              '${item.year}.${item.release_date}',
              maxLines: 1,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            item.genre,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          _isMovieItem ?
          Text(
            "${item.directors.join(" / ")}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13),
          ):
          item.description.isNotEmpty ?
          Text("\"${item.description}\"",
              maxLines: 2,
              style: TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis):
          SizedBox(),
          _isMovieItem ?
          Text(
            "${item.actors.join(" / ")}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13),
          ):
          SizedBox()
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    return Container(
      width: 80,
      child: Column(children: <Widget>[
        RatingLabel(item.rating.value.toString(),
            normalSize: 24, noneSize: 15, noneColor: Colors.grey),
        RatingStar(
            item.rating.fullCount,
            Icon(Icons.star, size: 16, color: Colors.amberAccent),
            item.rating.emptyCount,
            Icon(Icons.star_border, size: 16, color: Colors.amberAccent),
            halfCount: item.rating.halfCount,
            halfIcon:
                Icon(Icons.star_half, size: 16, color: Colors.amberAccent)),
        Consumer<LanguageViewModel>(builder: (context, _, child) {
          return Text(
            "${item.rating.count}${LocalizationManger.i18n(context, 'movie.scored')}",
            style: TextStyle(
              fontSize: 10,
            ),
          );
        })

      ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly),
    );
  }
}
