import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/photo_model.dart';
import 'package:douban/model/video_model.dart';
import 'package:douban/view/movie_player_view.dart';
import 'package:flutter/material.dart';

import 'movie_gallery_view.dart';

class MovieTrailersView extends StatelessWidget {
  BuildContext _context;
  EdgeInsetsGeometry margin;
  double height;

  List<VideoModel> videos;
  List<PhotoModel> photos;


  List<MovieGalleryItem> get galleryItems {
    return photos.map((v) {
      return MovieGalleryItem('trailer_${v.id}', v.image);
    }).toList();
  }

  MovieTrailersView(this.photos, this.videos,
      {this.margin = const EdgeInsets.only(top: 5), this.height = 150});

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Container(
        margin: margin,
        height: height,
        child: GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          children: _videoWidget + _photoWidget,
        ));
  }

  List<Widget> get _photoWidget {
    return photos.map((v) {
      final index = photos.indexOf(v);

      return Container(
        child: GestureDetector(
          onTap: () {
            MovieGalleryView.open(_context, galleryItems, index);
          },
          child: Hero(
            tag: v.id,
            child: CachedNetworkImage(imageUrl: v.image, fit: BoxFit.cover),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> get _videoWidget {

    return videos.map((v) {

      return Container(
        child: GestureDetector(
          onTap: () {
            MoviePlayerView.open(_context, v.resource_url);
          },
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              CachedNetworkImage(imageUrl: v.medium, fit: BoxFit.cover),
              Icon(Icons.play_circle_filled, size: 50, color: Colors.white)
            ],
          ),
        ),
      );
    }).toList();
  }
}
