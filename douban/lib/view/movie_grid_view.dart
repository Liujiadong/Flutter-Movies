import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/movie_model.dart';
import 'package:douban/view/base_view.dart';
import 'package:flutter/material.dart';

class MovieGridView extends StatelessWidget {
  
  MovieItem item;
  GestureTapCallback onTap;

  MovieGridView({
    this.item,
    this.onTap
  });

  
  @override
  Widget build(BuildContext context) {

    return Card(
        child: InkWell(
            onTap: onTap,
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
                borderRadius: BorderRadius.circular(3.0),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(item.cover),
                    fit: BoxFit.fill)
            )
        )
    );
  }

  get _buildTitle {
    return Padding(
      child: Text(
          item.title,
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
              item.rating.fullCount,
            Icon(Icons.star, size: 15, color: Colors.amberAccent),
              item.rating.emptyCount,
            Icon(Icons.star_border, size: 15, color: Colors.amberAccent),
              halfCount: item.rating.halfCount,
              halfIcon: Icon(Icons.star_half,
                  size: 15, color: Colors.amberAccent)

          ),
          RatingLabel(item.rating.value.toString(),
              normalSize: 10,
              noneSize: 10,
              noneColor: Colors.grey),
        ],
      ),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
    );
  }
}