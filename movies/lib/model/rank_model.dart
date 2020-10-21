import 'package:movies/model/movie_model.dart';
import 'base_model.dart';

class RankList extends BaseList {

  RankList.fromJson(json) : super.fromJson(json) {
    subjects = (json['selected_collections'] as List)
        .map( (json) => RankListItem.fromJson(json))
        .toList();
  }

}

class RankListItem {
  String name;
  String id;
  String header_bg_image;
  String cover_url;
  List<RankMovie> items;

  RankListItem.fromJson(json) {
    name = json['name'];
    header_bg_image = json['header_bg_image'];
    id = json['id'];
    cover_url = json['cover_url'];
    items = (json['items'] as List).map((v) => RankMovie.fromJson(v)).toList();
  }
}

class RankMovie {

  String title;
  String id;
  String cover;
  MovieRating rating;

  RankMovie.fromJson(json) {
    id = json['id'];
    title = json['title'];
    cover = json['pic']['normal'].toString().replaceAll('webp', 'jpg');
    rating = MovieRating.fromJson(json['rating']);
  }

}