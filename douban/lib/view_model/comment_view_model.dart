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

  _fetch(int start) async {

    final response = await NetworkManager.get(Api.fetchMovie, extra: extra, data: {
      "start": start,
      "count": 10,
      'id': id
    });

    final _comments = Comments.fromJson(response.data);
    

    if (viewState == ViewState.onRefresh ||
        viewState == ViewState.refreshCompleted) {
      comments =  _comments;
    } else {
      comments.subjects.addAll(_comments.subjects);
    }

  }

  onRefresh() async {
    setViewState(ViewState.onRefresh);
    await _fetch(0);
    setViewState(ViewState.refreshCompleted);
  }


  onLoading() async {

    if (comments.subjects.length >= comments.total) {
      setViewState(ViewState.loadNoData);
    } else {
      setViewState(ViewState.onLoading);
      await _fetch(comments.subjects.length);
      setViewState(ViewState.loadComplete);
    }

  }
}