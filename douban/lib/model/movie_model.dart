
class Movie {

  String title;
  String cover;

  ColorScheme color;

  Rating rating;
  List<Staff> actors;
  List<Staff> directors;

  Photo trailer;

  bool released;
  String intro;
  String pubdate;
  String durations;
  String languages;
  String countries;
  String genres;
  String id;
  String url;


  List<Staff> get staffs {
    actors.forEach((v) => v.title = '');
    directors.forEach((v) => v.title = 'movie.director');
    return directors + actors;
  }

  Movie.fromJson(json) {

    id = json['id'];
    title = json['title'];
    cover = json['pic']['normal'].toString().replaceAll('webp', 'jpg');
    rating = Rating.fromJson(json['rating']);
    actors = (json['actors'] as List).map((v) => Staff.fromJson(v)).toList();
    directors = (json['directors'] as List).map((v) => Staff.fromJson(v)).toList();
    color = ColorScheme.fromJson(json['color_scheme']);
    intro = json['intro'];
    url = json['info_url'];


    if (json['trailer'] != null) {
      trailer = Photo.fromJson(json['trailer']);
    }

    released = json['is_released'];
    pubdate = (json['pubdate'] as List).join(' / ');
    durations = (json['durations'] as List).join(' / ');
    genres = (json['genres'] as List).join(' / ');
    languages = (json['languages'] as List).join(' / ');
    countries = (json['countries'] as List).join(' / ');
  }

}

class MovieItem {

  String title;
  String subtitle;
  String info;
  String cover;

  Rating rating;

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


  MovieItem.fromJson(json) {

    id = json['id'];
    title = json['title'];
    subtitle = json['card_subtitle'];
    info = json['info'];
    cover = json['cover']['url'].toString().replaceAll('webp', 'jpg');
    rating = Rating.fromJson(json['rating']);
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
  Rating rating;


  MovieGridItem.fromJson(json) {

    id = json['id'];
    title = json['title'];
    cover = json['pic']['normal'].toString().replaceAll('webp', 'jpg');
    rating = Rating.fromJson(json['rating']);
    url = json['url'];

  }

  MovieGridItem.from(MovieItem movie) {

    id = movie.id;
    title = movie.title;
    cover = movie.cover;
    rating = movie.rating;

  }

}


class Rating {

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


  Rating.fromJson(json) {
    if (json != null) {
      value = json['value'];
      stars = json['star_count'].toString();
      count = json['count'];
    }

  }

}


class ColorScheme {

  bool isDark;
  String dark;
  String light;
  String secondary;

  get primary {
    return '#${isDark ? dark : light}';
  }

  ColorScheme.fromJson(json) {
    isDark = json['is_dark'];
    dark = json['primary_color_dark'];
    light = json['primary_color_light'];
    secondary = json['secondary_color'];
  }
}

class Staff {
  String id;
  String name;
  String avatar;
  String title;

  Staff.fromJson(json) {
    id = json['id'];
    name = json['name'];
    avatar = json['cover_url'];
  }
}

class Photo {
  String id;
  String title;
  String cover;
  String video;

  Photo.fromJson(json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover_url'];
    video = json['video_url'];
  }
}


class CommentItem {
  Rating rating;
  num useful_count;
  String title;
  String url;
  String abstract;
  String create_time;
  User user;

  CommentItem.fromJson(json) {
    rating = Rating.fromJson(json['rating']);
    useful_count = json['useful_count'] ?? json['vote_count'];
    title = json['title'];
    url = json['sharing_url'];
    abstract = json['abstract'] ?? json['comment'];
    create_time = json['create_time'];
    user = User.fromJson(json['user']);
  }
}

class User {
  String name;
  String avatar;

  User.fromJson(json) {
    name = json['name'];
    avatar = json['avatar'];
  }

}