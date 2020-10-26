import 'package:movies/model/movie_model.dart';
import 'package:movies/model/rank_model.dart';
import 'package:movies/util/constant.dart';
import 'package:movies/view_model/base_view_model.dart';

class RankViewModel extends BaseListViewModel<RankList> {

  @override
  String get api => Api.fetchRanks;

  @override
  RankList modelFromJson(json) {
    return RankList.fromJson(json);
  }

}

class RankListViewModel extends BaseListViewModel<MovieList> {

  RankListViewModel(id):super(id: id);


  @override
  String get api => Api.fetchMovieList;

  @override
  String get extra => Api.itemsPath(id);

  @override
  MovieList modelFromJson(json) {
    return MovieList.fromJson(json);
  }

}