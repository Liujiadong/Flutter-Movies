import 'package:douban/model/movie_model.dart';

abstract class ListModel {

  num count;
  num start;
  num total;
  List subjects;

  ListModel({
    this.count,
    this.start,
    this.total,
    this.subjects,
  });

}

class Movies extends ListModel {
  Movies.fromJson(json) {
    count = json['count'];
    start = json['start'];
    total = json['total'];
    subjects = (json['subjects'] as List).map( (json) => MovieModel.fromJson(json)).toList();
  }
}

class Comments extends ListModel {

  Comments.fromJson(json) {
    count = json['count'];
    start = json['start'];
    total = json['total'];
    subjects = json['comments'] ?? json['reviews'];
  }

}
