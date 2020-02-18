import 'package:dio/dio.dart';
import 'package:douban/model/list_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/network_manager.dart';
import 'package:douban/view_model/viewState_view_model.dart';

class CommentViewModel extends ViewStateViewModel {

  Comments comments;

  String id;
  String extra;

  CommentViewModel(this.id, this.extra){
    onRefresh();
  }

  Future<Response> _fetch(int start) async {

    final response = await NetworkManager.get(Api.fetchMovie, extra: extra, data: {
      "start": start,
      "count": 10,
      'id': id
     });

    return response;
    final _comments = Comments.fromJson(response.data);
    

    if (viewState == ViewState.onRefresh ||
        viewState == ViewState.refreshCompleted) {
      comments =  _comments;
    } else {
      comments.subjects.addAll(_comments.subjects);
    }

  }

  onRefresh() {

    setViewState(ViewState.onRefresh);
    _fetch(0).then((response) {
      final _comments = Comments.fromJson(response.data);
      comments =  _comments;
      setViewState(ViewState.refreshCompleted);
    }, onError:(error) {
      setViewState(ViewState.refreshError, message: error.message);
    });

  }


  onLoading() {

    if (comments.subjects.length >= comments.total) {
      setViewState(ViewState.loadNoData);
    } else {
      setViewState(ViewState.onLoading);
      _fetch(comments.subjects.length).then((response) {
        final _comments = Comments.fromJson(response.data);
        comments.subjects.addAll(_comments.subjects);
        setViewState(ViewState.loadComplete);
      }, onError:(error) {
        setViewState(ViewState.loadError, message: error.message);
      });
    }

  }
}