import 'package:douban/model/photo_model.dart';
import 'package:douban/model/rating_model.dart';
import 'package:douban/model/staff_model.dart';
import 'package:douban/model/video_model.dart';

class MovieModel {
  RatingModel rating;
  List genres;
  String title;
  List<StaffModel> casts;
  List durations;
  num collect_count;
  num ratings_count;
  num comments_count;
  String mainland_pubdate;
  String original_title;
  String summary;

  List<StaffModel> directors;
  List pubdates;
  String year;
  Map images;

  String alt;
  String id;

  String share_url;


  List popular_comments;
  List<VideoModel> bloopers;
  List<VideoModel> trailers;
  List<PhotoModel> photos;

  get smallImage {
    return images["small"];
  }

  get largeImage {
    return images["large"];
  }


  List<VideoModel> get videos {
    return trailers + bloopers;
  }

  List<StaffModel> get staffs {
    final _casts = casts;
    _casts.forEach((casts) => casts.title = '');
    final _directors = directors;
    _directors.forEach((director) => director.title = '导演');
    return _directors + _casts;
  }

  MovieModel({
    this.rating,
    this.genres,
    this.title,
    this.casts,
    this.durations,
    this.collect_count,
    this.mainland_pubdate,
    this.original_title,
    this.directors,
    this.pubdates,
    this.year,
    this.images,
    this.alt,
    this.id,
    this.share_url,
  });

  MovieModel.fromJson(json) {
    rating = RatingModel.fromJson(json['rating']);
    genres = json['genres'];
    title = json['title'];
    casts = (json['casts'] as List).map( (json) => StaffModel.fromJson(json)).toList();
    durations = json['durations'];
    collect_count = json['collect_count'];
    mainland_pubdate = json['mainland_pubdate'];
    original_title = json['original_title'];
    directors = (json['directors'] as List).map( (json) => StaffModel.fromJson(json)).toList();
    pubdates = json['pubdates'];
    year = json['year'];
    images = json['images'];
    alt = json['alt'];
    id = json['id'];
    share_url = json['share_url'];
    summary = json['summary'];

    if (json['photos'] != null) {
      photos = (json['photos'] as List).map( (json) => PhotoModel.fromJson(json)).toList();
      trailers = (json['trailers'] as List).map( (json) => VideoModel.fromJson(json)).toList();
      bloopers = (json['bloopers'] as List).map( (json) => VideoModel.fromJson(json)).toList();
      ratings_count = json['ratings_count'];
      comments_count = json['comments_count'];
      popular_comments = json['popular_comments'];
    }


  }
}