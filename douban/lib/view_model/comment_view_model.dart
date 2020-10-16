import 'package:dio/dio.dart';
import 'package:douban/model/list_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/network_manager.dart';
import 'package:douban/view_model/base_view_model.dart';
import 'package:douban/view_model/viewState_view_model.dart';

class CommentViewModel extends BaseViewModel {

  Comments comments;

  String id;
  String path;

  int _start = 1;

  CommentViewModel(this.id, this.path){
    onRefresh();
  }

  @override
  bool get isEmpty => comments.subjects.isEmpty;

  @override
  String get api => Api.fetchMovie;

  @override
  String get extra => path;

  @override
  get data => {
    'id': id,
    'start': _start,
    'count': 10
  };

  @override
  bool get loadNoData => comments.subjects.length >= comments.total;

  @override
  bool get refreshNoData {
    if (comments != null) {
      return isEmpty;
    }
    return true;
  }

  @override
  onRefresh() {
    _start = 1;
    super.onRefresh();
  }

  @override
  onLoading() {
    _start = comments.subjects.length;
    super.onLoading();
  }

  @override
  refreshCompleted(json) {
    comments = Comments.fromJson(json);
  }

  @override
  loadComplete(json) {
    final _comments = Comments.fromJson(json);
    comments.subjects.addAll(_comments.subjects);
  }

}