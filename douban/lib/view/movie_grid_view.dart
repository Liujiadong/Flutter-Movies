import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/movie_model.dart';
import 'package:douban/view/base_view.dart';
import 'package:flutter/material.dart';

class MovieGridView extends StatelessWidget {
  
  MovieModel movie;
  Function(BuildContext) onTap;

  MovieGridView({
    this.movie,
    this.onTap
  });

  
  @override
  Widget build(BuildContext context) {

    return Card(
        child: InkWell(
            onTap: () {
              onTap(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildImage,
                _buildTitle,
                _buildRating

              ],
            )

        )
    );
  }

  get _buildImage {

    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(3.0),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(movie.largeImage),
                    fit: BoxFit.fill)))
    );
  }

  get _buildTitle {
    return Padding(
      child: Text(
          movie.title,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold)
      ),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
    );
  }

  get _buildRating {
    return Padding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RatingStar(
              movie.rating.fullCount,
            Icon(Icons.star, size: 15, color: Colors.amberAccent),
            movie.rating.emptyCount,
            Icon(Icons.star_border, size: 15, color: Colors.amberAccent),
              halfCount: movie.rating.halfCount,
              halfIcon: Icon(Icons.star_half,
                  size: 15, color: Colors.amberAccent)

          ),
          RatingLabel(movie.rating.average.toString(),
              normalSize: 10,
              noneSize: 10,
              noneColor: Colors.grey),
        ],
      ),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
    );
  }
}