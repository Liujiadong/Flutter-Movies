import 'base_model.dart';

class MovieList extends BaseList {

  MovieList.fromJson(json) : super.fromJson(json) {
    id = json['subject_collection']['id'];
    name = json['subject_collection']['name'];
    subjects = (json['subject_collection_items'] as List)
        .map( (json) => MovieListItem.fromJson(json))
        .toList();

  }

}

class Movie {

  String title;
  String cover;

  MovieColor color;

  MovieRating rating;
  List<MovieStaff> actors;
  List<MovieStaff> directors;

  MovieTrailer trailer;

  bool released;
  String intro;
  String pubdate;
  String durations;
  String languages;
  String countries;
  String genres;
  String id;
  String url;

  List<MovieStaff> get staffs {
    actors.forEach((v) => v.title = '');
    directors.forEach((v) => v.title = 'movie.director');
    return directors + actors;
  }

  Movie.fromJson(json) {

    id = json['id'];
    title = json['title'];
    cover = json['pic']['normal'].toString().replaceAll('webp', 'jpg');
    rating = MovieRating.fromJson(json['rating']);
    actors = (json['actors'] as List).map((v) => MovieStaff.fromJson(v)).toList();
    directors = (json['directors'] as List).map((v) => MovieStaff.fromJson(v)).toList();
    color = MovieColor.fromJson(json['color_scheme']);
    intro = json['intro'];
    url = json['info_url'];


    if (json['trailer'] != null) {
      trailer = MovieTrailer.fromJson(json['trailer']);
    }

    released = json['is_released'];
    pubdate = (json['pubdate'] as List).join(' / ');
    durations = (json['durations'] as List).join(' / ');
    genres = (json['genres'] as List).join(' / ');
    languages = (json['languages'] as List).join(' / ');
    countries = (json['countries'] as List).join(' / ');
  }

}

class MovieListItem {

  String title;
  String subtitle;
  String info;
  String cover;

  MovieRating rating;

  List actors;
  List directors;

  String year;
  String release_date;

  String original_title;


  String id;


  String description;

  get genre {
    final list = info.split('/');
    if (list.length > 2) {
      return list[1].trim();
    }
    return info;
  }


  MovieListItem.fromJson(json) {

    id = json['id'];
    title = json['title'];
    subtitle = json['card_subtitle'];
    info = json['info'];
    cover = json['cover']['url'].toString().replaceAll('webp', 'jpg');
    rating = MovieRating.fromJson(json['rating']);
    actors = json['actors'];
    directors = json['directors'];
    year = json['year'];
    release_date = json['release_date'];
    original_title = json['original_title'];
    description = json['description'];

  }

}

class MovieGridItem {

  String id;
  String title;
  String cover;
  String url;
  MovieRating rating;

  MovieGridItem.fromJson(json) {

    id = json['id'];
    title = json['title'];
    cover = json['pic']['normal'].toString().replaceAll('webp', 'jpg');
    rating = MovieRating.fromJson(json['rating']);
    url = json['url'];

  }

  MovieGridItem.from(MovieListItem movie) {

    id = movie.id;
    title = movie.title;
    cover = movie.cover;
    rating = movie.rating;

  }

}


class MovieRating {

  num value = 0;
  String stars = '0.0';
  num count = 0;

  get fullCount {
    return num.parse(stars[0]).toInt();
  }

  get halfCount {
    if (stars.length > 2) {
      return num.parse(stars[2] ?? 0) ~/ 5;
    }
    return 0;
  }

  get emptyCount {
    return 5 - fullCount - halfCount;
  }


  MovieRating.fromJson(json) {
    if (json != null) {
      value = json['value'];
      stars = json['star_count'].toString();
      count = json['count'];
    }

  }

}


class MovieColor {

  bool isDark;
  String dark;
  String light;
  String secondary;

  get primary {
    return '#${isDark ? dark : light}';
  }

  MovieColor.fromJson(json) {
    isDark = json['is_dark'];
    dark = json['primary_color_dark'];
    light = json['primary_color_light'];
    secondary = json['secondary_color'];
  }

}

class MovieStaff {
  String id;
  String name;
  String avatar;
  String title;

  MovieStaff.fromJson(json) {
    id = json['id'];
    name = json['name'];
    avatar = json['cover_url'];
  }
}

class MovieTrailer {
  String id;
  String title;
  String cover;
  String video;

  MovieTrailer.fromJson(json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover_url'];
    video = json['video_url'];
  }
}


