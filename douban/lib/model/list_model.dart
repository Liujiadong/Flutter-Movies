import 'package:douban/model/movie_model.dart';
import 'package:douban/model/rank_model.dart';

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
    subjects = (json['subject_collection_items'] as List).map( (json) => MovieItem.fromJson(json)).toList();
  }
}

class Comments extends ListModel {

  Comments.fromJson(json) {
    count = json['count'];
    start = json['start'];
    total = json['total'];
    subjects = ((json['interests'] ?? json['reviews'])  as List).map( (json) => CommentItem.fromJson(json)).toList();
  }

}

class Ranks extends ListModel {
  Ranks.fromJson(json) {
    count = json['count'];
    start = json['start'];
    total = json['total'];
    subjects = (json['selected_collections']  as List).map( (json) => RankItem.fromJson(json)).toList();
  }
}
