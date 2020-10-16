import 'package:douban/model/movie_model.dart';

class RankItem {
  String name;
  String id;
  String header_bg_image;
  String cover_url;
  List<RankMovie> items;

  RankItem.fromJson(json) {
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
  Rating rating;

  RankMovie.fromJson(json) {
    id = json['id'];
    title = json['title'];
    cover = json['pic']['normal'].toString().replaceAll('webp', 'jpg');
    rating = Rating.fromJson(json['rating']);
  }
}