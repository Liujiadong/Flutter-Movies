
class BaseList {

  num count, start, total;

  List subjects;

  String id, name;

  BaseList.fromJson(json){

    count = json['count'];
    start = json['start'];
    total = json['total'];

  }

}

class BaseMovie {

  String id, title, name;
  BaseRating rating;

  BaseMovie();

  BaseMovie.fromJson(json){
    id = json['id'];
    title = json['title'];
    name = json['name'];
    rating = BaseRating.fromJson(json['rating']);
  }

}

class BaseRating {

  num value = 0, count = 0;

  String stars = '0.0';

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


  BaseRating.fromJson(json) {
    if (json != null) {
      value = json['value'];
      stars = json['star_count'].toString();
      count = json['count'];
    }

  }

}

class BaseColor {

  bool isDark;

  String dark, light, secondary;

  get primary {
    return '#${isDark ? dark : light}';
  }

  BaseColor.fromJson(json) {
    isDark = json['is_dark'];
    dark = json['primary_color_dark'];
    light = json['primary_color_light'];
    secondary = json['secondary_color'];
  }

}

class GalleryItem {
  String id, url;
  GalleryItem(this.id, this.url);
}


